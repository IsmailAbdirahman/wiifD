import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:wiifd/main.dart';
import 'package:wiifd/screens/intro_screen/intro_screen_model.dart';
import 'package:wiifd/screens/signing_screen/sign_in_screen.dart';
import 'package:wiifd/utilties/constants.dart';
import 'package:wiifd/widgets/build_intro_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroScreen extends ConsumerWidget {
  void _onIntroEnd(context, [WidgetRef? ref]) async {
    ref!.read(introScreenProvider.notifier).saveStatus();

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      globalBackgroundColor: Colors.white,

      pages: [
        PageViewModel(
          title: firstIntroScreen.title,
          body: firstIntroScreen.body,
          image: BuildIntroImage(assetName: firstIntroScreen.image),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: secondIntroScreen.title,
          body: secondIntroScreen.body,
          image: BuildIntroImage(assetName: secondIntroScreen.image),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: thirdIntroScreen.title,
          body: thirdIntroScreen.body,
          image: BuildIntroImage(assetName: thirdIntroScreen.image),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context, ref),
      onSkip: () => _onIntroEnd(context, ref),
      // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      skip: const Text('Skip',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
      next: const SizedBox.shrink(),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      //  controlsMargin: const EdgeInsets.all(16),
      //controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
