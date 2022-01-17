import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/app_state/todo_state.dart';
import 'package:wiifd/data_model/todo_info_model.dart';
import 'package:wiifd/data_source/supabase_db.dart';
import 'package:wiifd/screens/settings/settings_model.dart';

import '../../main.dart';

final todoProvider =
    StateNotifierProvider.autoDispose<TodoModel, TodoState>((ref) {
  final dataStore = ref.watch(supabaseProvider);
   final coins = 100;
  // logger.e(coins);

  return TodoModel(supabaseDB: dataStore, availableCoins: coins);
});

//--
class TodoModel extends StateNotifier<TodoState> {
  TodoModel({required this.supabaseDB, required this.availableCoins})
      : super(TodoState.loading());

  final SupabaseDB supabaseDB;
  final availableCoins;

  addTodo({String? title, String? description}) async {
    if (availableCoins < 10) {
      throw ("can't post todo");
    }
    int coinForThisTodo = 10;
    int remainingCoins = availableCoins - coinForThisTodo;
    int createdAt = DateTime.now().millisecondsSinceEpoch;
    int deleteAt =
        DateTime.now().add(Duration(hours: 24)).millisecondsSinceEpoch;
    int notifyTime =
        DateTime.now().add(Duration(hours: 20)).millisecondsSinceEpoch;
    FirebaseAuth auth = FirebaseAuth.instance;
    String userUID = auth.currentUser!.uid;
    TodoInfo todoInfo = TodoInfo(
        userUID: userUID,
        id: uuid.v1(),
        title: title,
        description: description,
        coins: coinForThisTodo,
        notifyTime: notifyTime,
        createdAt: createdAt,
        deleteAt: deleteAt);
    if (todoInfo.title == null) {
      state = TodoState.error("Title can't be empty");
      return false;
    }
    try {
      final data = todoInfo;
      state = TodoState.loading();
      await supabaseDB.addTodoInfo(data);
      supabaseDB.updateCoins(remainingCoins);
    } catch (e) {
      throw (e);
    }
  }
}

//TODO: Update automatically the remaining coins, after inserting data to todo table.
//TODO: Try to understand how state works. it related to future.provider this one ['userInfoAsync']
