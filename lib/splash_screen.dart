import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:millions_recipe/providers/theme_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import './screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'landing.dart';

class SplashScreen extends StatelessWidget {
  final String? logedin;
  const SplashScreen({Key? key, required this.logedin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: AnimatedSplashScreen(
        splash: themeProvider.isDarkMode
            ? Image.asset("assets/new_million_logo.png")
            : Image.asset('assets/logo.png'),
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
