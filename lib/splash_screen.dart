import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import './screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'landing.dart';

class SplashScreen extends StatelessWidget {
  final String? logedin;
  const SplashScreen({Key? key, required this.logedin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: AnimatedSplashScreen(
        splash: Image.asset('assets/logo.png'),
        duration: 3000,
        curve: Curves.easeInOut,
        splashIconSize: 350,
        splashTransition: SplashTransition.slideTransition,
        animationDuration: const Duration(milliseconds: 1500),
        backgroundColor: Theme.of(context).colorScheme.background,
        // Colors.white,
        pageTransitionType: PageTransitionType.fade,
        nextScreen: logedin != null ? const Landing() : const Onbording(),
      ),
    );
  }
}
