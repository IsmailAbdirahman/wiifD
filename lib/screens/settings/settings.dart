import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/app_state/settings_state.dart';
import 'package:wiifd/data_model/profile_settings.dart';
import 'package:wiifd/data_source/supabase_db.dart';
import 'package:wiifd/main.dart';
import 'package:wiifd/screens/settings/settings_model.dart';

final settingsProvider =
    StateNotifierProvider<SettingsModel, SettingsState>((ref) {
  final dataStore = ref.watch(supabaseProvider);

  return SettingsModel(supabaseDB: dataStore);
});

class SettingsScreen extends ConsumerStatefulWidget {
  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends ConsumerState<SettingsScreen> {
  TextEditingController? nameController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(settingsProvider);
    state.when(
        initializing: () =>
            nameController = TextEditingController(text: "Loading..."),
        error: (d) => Text("Something went wrong"),
        loaded: (data) =>
            nameController = TextEditingController(text: data.name));

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
            ElevatedButton(
                onPressed: () async {
                  final model = ref.watch(settingsProvider.notifier);
                  final success = await model.updateName(
                      ProfileSettings(name: nameController!.value.text));
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
