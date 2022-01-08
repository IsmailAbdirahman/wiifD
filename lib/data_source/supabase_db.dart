import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/data_model/profile_settings.dart';
import 'package:wiifd/utilties/app_config.dart';

final supabaseProvider = Provider((ref) => SupabaseDB());

class SupabaseDB {
  //------ USer Profile -----------
  Future<bool> saveUserInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String userUID = auth.currentUser!.uid;
    String? name = auth.currentUser!.displayName;
    String? email = auth.currentUser!.email;
    final res = await client
        .from('user_info')
        .insert({'userUID': userUID, 'name': name, 'email': email}).execute();
    if (res.error != null) {
      return false;
    } else {
      loadProfileInfo();
      return true;
    }
  }

  updateName(String name) async {
    final res = await client.from('user_info').update({'name': name}).execute();
    if (res.error != null) {
      print("Something went wrong");
    }
    loadProfileInfo();
  }

  Future<ProfileSettings> loadProfileInfo() async {
    final res = await client.from('user_info').select().execute();
    if (res.error != null) {
      throw ("something went wrong");
    }
    return res.data;
  }

// ---------- To do Info ----------------
//save data to the database:
// userUID, title, description, time

// get all info

}
