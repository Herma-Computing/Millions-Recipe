import 'package:flutter/material.dart';
import 'package:millions_recipe/landing.dart';
import './providers/meal_provider.dart';
import './providers/recipe_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import './screens/on_boarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Meals(),
        ),
        ChangeNotifierProvider(create: (_) => Recipes())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.montserratTextTheme(),
          ),
          debugShowCheckedModeBanner: false,
          home: const Onbording()),
    );
  }
}
