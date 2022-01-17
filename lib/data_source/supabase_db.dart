import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/app_state/settings_state.dart';
import 'package:wiifd/data_model/profile_settings.dart';
import 'package:wiifd/data_model/todo_info_model.dart';
import 'package:wiifd/main.dart';
import 'package:wiifd/utilties/app_config.dart';

final supabaseProvider = Provider((ref) => SupabaseDB());

class SupabaseDB {
  //------ USer Profile -----------

  saveUserInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String userUID = auth.currentUser!.uid;
    String? name = auth.currentUser!.displayName;
    String? email = auth.currentUser!.email;
    int availableCoins = 20;
    final res = await client.from('user_info').insert({
      'userUID': userUID,
      'name': name,
      'email': email,
      'available_coins': availableCoins
    }).execute();
    if (res.error != null) {}
  }

 Future<ProfileSettings> updateName(String name) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String userUID = auth.currentUser!.uid;
    final res = await client
        .from('user_info')
        .update({'name': name})
        .eq("userUID", userUID)
        .execute();
    if (res.error != null) {
      throw ("res.error");
    }
    return loadProfileInfo();

  }

  Future<ProfileSettings> loadProfileInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String userUID = auth.currentUser!.uid;
    final res = await client
        .from('user_info')
        .select()
        .eq("userUID", userUID)
        .execute();
    if (res.error != null) {
      throw ("something went wrong");
    }
    List<dynamic> dynamicData = res.data;
    final data = dynamicData.map((e) => ProfileSettings.fromJson(e)).toList();
    return data[0];
  }

  updateCoins(int remainingCoins) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String userUID = auth.currentUser!.uid;
    final res = await client
        .from('user_info')
        .update({'availableCoins': remainingCoins})
        .eq('userUID', userUID)
        .execute();
  }

// ---------- To do Info ----------------

  addTodoInfo(TodoInfo todoInfo) async {
    final res = await client.from('todo_info').insert({
      'id': todoInfo.id,
      'userUID': todoInfo.userUID,
      'title': todoInfo.title,
      'description': todoInfo.description,
      'coins': todoInfo.coins,
      'created_at': todoInfo.createdAt,
      'delete_at': todoInfo.deleteAt,
      'notify_time': todoInfo.notifyTime,
    }).execute();
    if (res.error != null) {
      throw ("Something went wrong::: ${res.error}");
    }
  }
}