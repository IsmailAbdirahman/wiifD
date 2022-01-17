import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:wiifd/app_state/settings_state.dart';
import 'package:wiifd/utilties/app_colors.dart';
import 'package:wiifd/widgets/button_nav.dart';
import 'screens/settings/settings.dart';
import 'screens/signing_screen/sign_in_screen.dart';
import 'firebase_options.dart';

var logger = Logger();
var uuid = Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
  ));
  runApp(ProviderScope(child: MyApp()));
}

// void main() => runApp(
//   DevicePreview(
//     enabled: !kReleaseMode,
//     builder: (context) => MyApp(), // Wrap your app
//   ),
// );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        FlutterFireUILocalizations.withDefaultOverrides(const LabelOverrides()),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterFireUILocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColor().createMaterialColor(Color(0XFF21135D)),
      ),
      home: LoginScreen(),
    );
  }
}

//TODO: Fix loading problem for first signing
