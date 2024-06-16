import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../core/Theme/constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
    required this.nextScreen,
    required Map<String, Widget Function(dynamic context)> routes,
  });
  final Widget nextScreen;
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: Image.asset(
        'assets/images/logo.png',
        width: 500,
      ),
      nextScreen: nextScreen,
      splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: kSecondarycolor,
    );
  }
}
