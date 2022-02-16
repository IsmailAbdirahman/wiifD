import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final introScreenProvider = StateNotifierProvider((ref) {
  final sharedPref = ref.watch(sharedPreferencesProvider);
  return IntroScreenModel(sharedPreferences: sharedPref);
});

class IntroScreenModel extends StateNotifier<bool> {
  IntroScreenModel({required this.sharedPreferences})
      : super(sharedPreferences.getBool("introScreenComplete") ?? false);

  final SharedPreferences sharedPreferences;

  saveStatus() {
    sharedPreferences.setBool('introScreenComplete', true);
  }

  bool getStatus() {
    bool? res = sharedPreferences.getBool('introScreenComplete');
    if (res != null && res) {
      return true;
    } else {
      return false;
    }
  }
}
