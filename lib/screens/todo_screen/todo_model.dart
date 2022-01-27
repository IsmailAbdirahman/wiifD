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

  Future<bool> addTodo(
      {String? title, String? description, String? timeToNotify}) async {
    state = TodoState.loading();
    if (title == '') {
      state = TodoState.error("Title can't be empty");
      return false;
    }
    final coins = await getRemainingCoins();
    if (coins < 10) {
      state = TodoState.error(
          "You wasted all your coins, get new coins and waste again!");
      return false;
    }
    int coinForThisTodo = 10;
    int remainingCoins = coins - coinForThisTodo;
    int createdAt = DateTime.now().millisecondsSinceEpoch;
    int deleteAt =
        DateTime.now().add(Duration(hours: 24)).millisecondsSinceEpoch;

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

  deleteTodo(String id) async {
    state = TodoState.loading();
    final avCoins = await getRemainingCoins();
    int returnCoins = avCoins + 10;
    await supabaseDB.updateCoins(returnCoins);
    final isDeleted = await supabaseDB.deleteTodo(id);
    if (isDeleted) {
      final data = await loadTodoInfo();
      state = TodoState.data(data);
    } else {
      state = TodoState.error('Something Went Wrong');
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

  String fromSinceEpoch(int timeAsInt) {
    DateTime now = DateTime.fromMillisecondsSinceEpoch(timeAsInt);
    TimeOfDay timeOfDay = TimeOfDay(hour: now.hour, minute: now.minute);
    String time = timeOfDay.hour.toString() + ":" + timeOfDay.minute.toString();
    return time;
  }
}
