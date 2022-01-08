import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/app_state/settings_state.dart';
import 'package:wiifd/data_source/supabase_db.dart';

class SettingsModel extends StateNotifier<SettingsState> {
  SettingsModel({required this.supabaseDB})
      : super(const SettingsState.noError());

  final SupabaseDB supabaseDB;

  Future<bool> updateName(String name) async {
    if (name.isEmpty) {
      state = SettingsState.error("name can not be empty");
      return false;
    }
    final dataName = name;
    state = SettingsState.loading();
    try {
      await supabaseDB.updateName(dataName);
      state = SettingsState.noError();
    } catch (e) {
      state = SettingsState.error(e.toString());
    }
    return true;
  }
}
