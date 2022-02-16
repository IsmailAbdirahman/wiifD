import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiifd/data_source/payment_source.dart';
import 'package:wiifd/screens/todo_screen/todo_info.dart';
import 'package:wiifd/utilties/app_colors.dart';
import 'package:wiifd/utilties/notification_service.dart';

import 'screens/intro_screen/intro_screen.dart';
import 'screens/intro_screen/intro_screen_model.dart';
import 'screens/signing_screen/sign_in_screen.dart';
import 'firebase_options.dart';

var logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().init();
  await PaymentSource().initKey();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
  ));
  final sharedPref = await SharedPreferences.getInstance();

  runApp(ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(sharedPref)],
      child: MyApp()));
}

// void main() => runApp(
//   DevicePreview(
//     enabled: !kReleaseMode,
//     builder: (context) => MyApp(), // Wrap your app
//   ),
// );

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TodoInfoScreen()),
      );
    });
  }

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
      home: Consumer(
        builder: (_, WidgetRef ref, __) {
          final info = ref.watch(introScreenProvider.notifier);
          if (info.getStatus()) {
            return LoginScreen();
          } else {
            return IntroScreen();
          }
        },
      ),
    );
  }
}
