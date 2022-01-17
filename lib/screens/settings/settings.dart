import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/app_state/settings_state.dart';
import 'package:wiifd/data_model/profile_settings.dart';
import 'package:wiifd/data_source/supabase_db.dart';
import 'package:wiifd/main.dart';
import 'package:wiifd/screens/settings/settings_model.dart';
import 'package:wiifd/utilties/app_colors.dart';

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
    final settingP = ref.watch(settingsProvider);

    // final stateInfo = ref.watch(userInfoAsync);
    settingP.when(
        loaded: (data) =>
        nameController = TextEditingController(text: data.name),
        error: (e) => nameController = TextEditingController(text:'Name is '),
        initializing: () => nameController = TextEditingController(text:'Wait'),);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor().backgroundColor,
        appBar: AppBar(
          title: Text(
            "Settings",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColor().backgroundColor,
        ),
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: InkWell(
                onTap: () {},
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, suffixIcon: Icon(Icons.edit)),
                ),
              ),
            ),
            ElevatedButton(
                style:
                ElevatedButton.styleFrom(primary: AppColor().primaryColor),
                onPressed: () async {
                  final model = ref.read(settingsProvider.notifier);
                  final success =
                  await model.updateName(nameController!.value.text);
                  if (success) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  } else {
                    print("not saved");
                  }
                },
                child: Text('Update')),
          ],
        ),
      ),
    );
  }
}
