import 'package:firebase_auth/firebase_auth.dart';
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

  // Future<bool> saveUserInfo() async {
  //   final res = await supabaseDB.saveUserInfo();
  //   if (res) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<bool> addTodo({String? title, String? description}) async {
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
      await supabaseDB.updateCoins(remainingCoins);
      await supabaseDB.loadTodoData().then((value) {
        state = TodoState.data(value);
      });
      return true;
    } catch (e) {
      throw (e);
    }
  }

  Future<List<TodoInfo>> loadTodoInfo() async {
    final data = await supabaseDB.loadTodoData();
    state = TodoState.data(data);
    return data;
  }
}
