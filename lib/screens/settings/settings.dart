import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/app_state/settings_state.dart';
import 'package:wiifd/data_model/profile_settings.dart';
import 'package:wiifd/data_source/supabase_db.dart';

import 'settings_model.dart';

final settingsProvider =
    StateNotifierProvider<SettingsModel, SettingsState>((ref) {
  final dataStore = ref.watch(supabaseProvider);

  return SettingsModel(supabaseDB: dataStore);
});

class SettingsScreen extends ConsumerWidget {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsProvider);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: InkWell(
                onTap: () {},
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(suffixIcon: Icon(Icons.edit)),
                ),
              ),
            ),
            state.when(
                noError: () => Text("wait"),
                error: (e) => Text(e),
                loading: () => CircularProgressIndicator()),
            ElevatedButton(
                onPressed: () async {
                  final model = ref.watch(settingsProvider.notifier);
                  final success =
                      await model.updateName(nameController.value.text);
                  if (success) {
                    print("Saved");
                  } else {
                    print("not saved");
                  }
                },
                child: Text('Save Changes')),
          ],
        ),
      ),
    );
  }
}
