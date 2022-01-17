import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:wiifd/screens/todo_screen/todo_info.dart';
import 'package:wiifd/utilties/app_config.dart';
import 'package:wiifd/widgets/button_nav.dart';

class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Column(
              children: [
                SizedBox(
                  height: 210,
                ),
                AspectRatio(
                    aspectRatio: 2,
                    child: Image(image: AssetImage("assets/images/todo.png"))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Welcome to WiiFD",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        wordSpacing: 2,
                        letterSpacing: 2,
                        fontSize: 18),
                  ),
                ),
                Expanded(
                  child: SignInScreen(
                    showAuthActionSwitch: false,
                    providerConfigs: [
                      GoogleProviderConfiguration(
                          clientId:
                              clientId)
                    ],
                  ),
                ),
              ],
            );
          } else {
            return ButtonNavWidget();
          }
        },
      ),
    );
  }
}

class LabelOverrides extends DefaultLocalizations {
  const LabelOverrides();

  @override
  String get signInWithGoogleButtonText => 'Login With Google';

  @override
  String get signInText => ' ';
}
