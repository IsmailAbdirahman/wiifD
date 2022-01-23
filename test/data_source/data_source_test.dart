import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase/supabase.dart';
import 'package:wiifd/app_state/settings_state.dart';
import 'package:wiifd/data_model/profile_settings.dart';
import 'package:wiifd/data_source/supabase_db.dart';
import 'package:wiifd/screens/settings/settings_model.dart';
import 'package:wiifd/screens/todo_screen/todo_model.dart';

import '../shared_mocks_test.dart';

void main() {
  late SupabaseDB mockedSupabaseDB;
  late ProviderContainer container;

  setUp(() {
    mockedSupabaseDB = MockSupabaseDb();

    container = ProviderContainer(overrides: [
      supabaseProvider.overrideWithValue(mockedSupabaseDB),
    ]);
    when(() => mockedSupabaseDB.saveUserInfo())
        .thenAnswer((invocation) => Future.value(true));



  });


  test('Save the user information to supabaseDB', () async {
    // ASSEMBLE
    when(() => mockedSupabaseDB.saveUserInfo()).thenAnswer(
      (invocation) => Future.value(true),
    );

    await container.read(settingsProvider.notifier).supabaseDB.saveUserInfo();
    expect(
        container.read(settingsProvider.notifier).supabaseDB, mockedSupabaseDB);
  });

  test("Check if the user can change and update the name", () async {
    final data = ProfileSettings(name: 'ism', availableCoins: 1);
    //ASSEMBLE
    when(() => mockedSupabaseDB.updateName(''))
        .thenAnswer((invocation) => Future.value(data));

    expect(
        await container.read(settingsProvider.notifier).updateName(''), false);

  });

  tearDown(() {
    container.dispose();
  });
}
