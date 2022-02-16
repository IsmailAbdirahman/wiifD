import 'package:wiifd/data_model/intro_screen_model.dart';

final firstIntroScreen = IntroScreenModel(
    title: "Only 5 Tasks each day",
    body: "To avoid overwhelming, You can only add 5 tasks each day.",
    image: "assets/images/todo.png");

final secondIntroScreen = IntroScreenModel(
    title: "Avoid losing coins",
    body:
        "Try to finish your Task before 24 hours and delete it from the list. ",
    image: 'assets/images/coin.gif');

final thirdIntroScreen = IntroScreenModel(
    title: "Don't cheat yourself",
    body: "Delete only the task you did.",
    image: 'assets/images/delete.gif');
