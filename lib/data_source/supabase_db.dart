import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/data_model/profile_settings.dart';
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
    final res = await client
        .from('user_info')
        .insert({'userUID': userUID, 'name': name, 'email': email}).execute();
    if (res.error != null) {}
  }

  updateName(String name) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String userUID = auth.currentUser!.uid;

    final res = await client
        .from('user_info')
        .update({'name': name})
        .eq("userUID", userUID)
        .execute();
    if (res.error != null) {
      print("Something went wrong");
    }
    loadProfileInfo();
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
    List<ProfileSettings> data =
        dynamicData.map((e) => ProfileSettings.fromJson(e)).toList();
    return data[0];
  }

// ---------- To do Info ----------------
//save data to the database:
// userUID, title, description, time

// get all info

}
