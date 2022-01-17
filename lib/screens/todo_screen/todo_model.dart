import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/app_state/todo_state.dart';
import 'package:wiifd/data_model/todo_info_model.dart';
import 'package:wiifd/data_source/supabase_db.dart';
import '../../main.dart';

final todoProvider = StateNotifierProvider<TodoModel, TodoState>((ref) {
  final dataStore = ref.watch(supabaseProvider);
  return TodoModel(supabaseDB: dataStore);
});

final todoFuture = FutureProvider.autoDispose((ref) async {
  final data = await ref.watch(todoProvider.notifier).loadTodoInfo();
  return data;
});

//--
class TodoModel extends StateNotifier<TodoState> {
  TodoModel({required this.supabaseDB}) : super(TodoState.loading()) {
    loadTodoInfo();
  }

  final SupabaseDB supabaseDB;

  Future<bool> addTodo({String? title, String? description}) async {
    state = TodoState.error("Title can't be empty");

    if (title == '') {
      state = TodoState.error("Title can't be empty");
      return false;
    }
    final info = await supabaseDB.loadProfileInfo();
    if (info.availableCoins! < 10) {
      state = TodoState.error("can't post todo Please pay coins");
      throw ("can't post todo Please pay coins");
    }
    int coinForThisTodo = 10;
    int remainingCoins = info.availableCoins! - coinForThisTodo;
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
        availableCoins: coinForThisTodo,
        notifyTime: notifyTime,
        createdAt: createdAt,
        deleteAt: deleteAt);

    try {
      final data = todoInfo;
      state = TodoState.loading();
      await supabaseDB.addTodoInfo(data);
      supabaseDB.updateCoins(remainingCoins);
      return true;
    } catch (e) {
      throw (e);
    }
  }

  Future<List<TodoInfo>> loadTodoInfo() async {
    final data = await supabaseDB.loadTodoData();
    return data;
  }
}
