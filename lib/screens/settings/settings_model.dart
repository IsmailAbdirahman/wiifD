import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/app_state/settings_state.dart';
import 'package:wiifd/data_model/profile_settings.dart';
import 'package:wiifd/data_source/supabase_db.dart';

import '../../main.dart';

class SettingsModel extends StateNotifier<SettingsState> {
  SettingsModel({required this.supabaseDB})
      : super(SettingsState.initializing()) {
    supabaseDB.saveUserInfo();
    supabaseDB.loadProfileInfo();
    getName();
  }

  final SupabaseDB supabaseDB;

  Future<bool> updateName(ProfileSettings profileInfo) async {
    if (profileInfo.name!.isEmpty) {
      state = SettingsState.error("Name can't be Empty");
      return false;
    }
    final dataName = profileInfo.name!;
    state = SettingsState.initializing();
    try {
      await supabaseDB.updateName(dataName);
      state = SettingsState.loaded(profileInfo);
    } catch (e) {}
    return true;
  }

  getName() {
    supabaseDB.loadProfileInfo().then((value) {
      state = SettingsState.loaded(value);
    });
  }
}
