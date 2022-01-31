import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/app_state/settings_state.dart';
import 'package:wiifd/app_state/todo_state.dart';
import 'package:wiifd/data_model/todo_info_model.dart';
import 'package:wiifd/data_source/supabase_db.dart';
import '../../main.dart';

final todoProvider = StateNotifierProvider<TodoModel, TodoState>((ref) {
  final dataStore = ref.watch(supabaseProvider);
  return TodoModel(supabaseDB: dataStore);
});

//--
class TodoModel extends StateNotifier<TodoState> {
  TodoModel({required this.supabaseDB}) : super(TodoState.loading()) {
    loadTodoInfo();
  }

  final SupabaseDB supabaseDB;

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

  Future<bool> addTodo(
      {String? title, String? description, String? timeToNotify}) async {
    state = TodoState.loading();
    final isListFull = await checkLengthOfTodo();
    final coins = await getRemainingCoins();

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
        id: uuid.v1(),
        title: title,
        description: description,
        availableCoins: coinForThisTodo,
        notifyTime: notifyTime,
        createdAt: createdAt,
        deleteAt: deleteAt);

    try {
      final data = todoInfo;
      state = TodoState.loading();
      await supabaseDB.addTodoInfo(data);
      await supabaseDB.updateCoins(remainingCoins);
      await supabaseDB.loadTodoData().then((value) {
        state = TodoState.data(value);
      });
      return true;
    } catch (e) {
      throw (e);
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
