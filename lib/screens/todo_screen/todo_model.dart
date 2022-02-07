import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/app_state/settings_state.dart';
import 'package:wiifd/app_state/todo_state.dart';
import 'package:wiifd/data_model/todo_info_model.dart';
import 'package:wiifd/data_source/supabase_db.dart';
import 'package:wiifd/utilties/notification_service.dart';
import '../../main.dart';

final todoProvider = StateNotifierProvider<TodoModel, TodoState>((ref) {
  final dataStore = ref.watch(supabaseProvider);
  final notification = ref.watch(notificationProvider);
  return TodoModel(supabaseDB: dataStore, notificationService: notification);
});

final lengthAndCoinProvider = FutureProvider.autoDispose((ref) async {
  final data = await ref.watch(todoProvider.notifier).checkTodoLengthAndCoins();
  return data;
});

//--
class TodoModel extends StateNotifier<TodoState> {
  TodoModel({required this.supabaseDB, required this.notificationService})
      : super(TodoState.loading()) {
    loadTodoInfo();
    checkTodoLengthAndCoins();
  }

  final SupabaseDB supabaseDB;
  final NotificationService notificationService;

  Future<int> getRemainingCoins() async {
    final coins = await supabaseDB.loadProfileInfo();
    return Future.value(coins.availableCoins);
  }

  Future<bool> checkLengthOfTodo() async {
    final todos = await loadTodoInfo();
    var length = todos.length;
    logger.w("THE LENGTH OF TODOS IS :::::--------- $length");
    if (length == 5) {
      return true;
    } else {
      return false;
    }
  }

  bool isListFull = true;
  int coins = -1;

  checkTodoLengthAndCoins() async {
    isListFull = await checkLengthOfTodo();
    coins = await getRemainingCoins();
  }

  bool checkTodoInput(String title) {
    state = TodoState.loading();

    if (title == '') {
      state = TodoState.error("Title can't be empty");
      return false;
    }

    if (isListFull) {
      logger.e("The list is full");
      state = TodoState.error("The list is full");
      return false;
    }

    if (coins < 10) {
      state = TodoState.error(
          "You wasted all your coins, get new coins and waste again!");
      return false;
    }
    return true;
  }

  Future<bool> addTodo(
      {String? title, String? description, String? timeToNotify}) async {
    state = TodoState.loading();
    if (checkTodoInput(title!)) {
      int coinForThisTodo = 10;
      int remainingCoins = coins - coinForThisTodo;
      int createdAt = DateTime.now().millisecondsSinceEpoch;
      int deleteAt =
          DateTime.now().add(Duration(minutes: 15)).millisecondsSinceEpoch;

      int notifyTime = toSinceEpoch(timeToNotify ?? null);

      FirebaseAuth auth = FirebaseAuth.instance;
      String userUID = auth.currentUser!.uid;
      TodoInfo todoInfo = TodoInfo(
          userUID: userUID,
          id: Random().nextInt(100).toString(),
          title: title,
          description: description,
          availableCoins: coinForThisTodo,
          notifyTime: notifyTime,
          createdAt: createdAt,
          deleteAt: deleteAt);

      try {
        final data = todoInfo;
        await supabaseDB.addTodoInfo(data);
        await notifyBeforeDeleting(data);
        await supabaseDB.updateCoins(remainingCoins);

        supabaseDB.loadTodoData().then((value) {
          state = TodoState.data(value);
        });
        return true;
      } catch (e) {
        logger.e(e);

        return false;
      }
    } else {
      return false;
    }
  }

  deleteTodo({String? id, bool? isDeletedByUser}) async {
    final avCoins = await getRemainingCoins();
    int returnCoins = avCoins + 10;
    if (id != null) {
      if (isDeletedByUser == true) {
        await supabaseDB.updateCoins(returnCoins);
      }
      final isDeleted = await supabaseDB.deleteTodo(id);
      if (isDeleted) {
      } else {
        state = TodoState.error('Something Went Wrong');
      }
    }
    notificationService.deleteNotificationID(int.parse(id!));
  }

  Future<bool> deleteLateTodo(int index) async {
    var todo = await loadTodoInfo();
    DateTime deleteTime = fromSinceEpoch(todo[index].deleteAt!);
    if (DateTime.now().isAfter(deleteTime)) {
      await deleteTodo(id: todo[index].id!, isDeletedByUser: false);
      return true;
    } else {
      return false;
    }
  }

  Future<List<TodoInfo>> loadTodoInfo() async {
    final data = await supabaseDB.loadTodoData();
    state = TodoState.data(data);
    return data;
  }

  notifyBeforeDeleting(TodoInfo todoInfo) async {
    await notificationService.notifyBeforeDeleting(todoInfo);
  }

//--------Time Converter------

  int toSinceEpoch(String? time) {
    if (time != null) {
      return DateTime.parse(time).millisecondsSinceEpoch;
    } else {
      return DateTime.now().add(Duration(hours: 10)).millisecondsSinceEpoch;
    }
  }

  DateTime fromSinceEpoch(int time) {
    DateTime convertedTime = DateTime.fromMillisecondsSinceEpoch(time);
    return convertedTime;
  }

  String timeToNotifyConverter(int timeAsInt) {
    DateTime now = DateTime.fromMillisecondsSinceEpoch(timeAsInt);
    TimeOfDay timeOfDay = TimeOfDay(hour: now.hour, minute: now.minute);
    String time = timeOfDay.hour.toString() + ":" + timeOfDay.minute.toString();
    return time;
  }
}
