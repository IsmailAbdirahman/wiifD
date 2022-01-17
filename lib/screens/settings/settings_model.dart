import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/app_state/settings_state.dart';
import 'package:wiifd/data_model/profile_settings.dart';
import 'package:wiifd/data_source/supabase_db.dart';

final settingsProvider =
    StateNotifierProvider<SettingsModel, SettingsState>((ref) {
  final dataStore = ref.watch(supabaseProvider);
  return SettingsModel(supabaseDB: dataStore);
});



final futureData = FutureProvider((ref){
  final data = ref.watch(settingsProvider.notifier).getInfo();
  return data;
});

//--
class SettingsModel extends StateNotifier<SettingsState> {
  SettingsModel({required this.supabaseDB})
      : super(SettingsState.initializing()) {
    supabaseDB.saveUserInfo();
    supabaseDB.loadProfileInfo();
    getInfo();
  }

  final SupabaseDB supabaseDB;

  Future<bool> updateName(String name) async {
    if (name.isEmpty) {
      state = SettingsState.error("Name can not be empty");
      return false;
    }
    state = SettingsState.initializing();
    final data = await supabaseDB.updateName(name);
    state = SettingsState.loaded(data);

    return true;
  }

  Future<SettingsState> getInfo() async {
    final data = await supabaseDB.loadProfileInfo();
    state = SettingsState.loaded(data);
    return state;
  }
}
