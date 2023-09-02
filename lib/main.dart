import 'package:flutter/material.dart';
import 'package:millions_recipe/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './providers/meal_provider.dart';
import './providers/recipe_provider.dart';
import 'package:provider/provider.dart';
import 'api/shared_preference/shared_preference.dart';
import 'database/database_helper.dart';
import 'splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  await DarkThemeProvider.init();
  SharedPreferences sharedPreferennces = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferennces.getString("token")));
  final db = await SqlHelper.db();
  await SqlHelper.createTables(db);
  // runApp(const MyApp("kl"));
}

class MyApp extends StatefulWidget {
  final String? logedin;
  const MyApp(this.logedin, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Meals(),
        ),
        ChangeNotifierProvider(
          create: (_) => DarkThemeProvider(),
        ),
        ChangeNotifierProvider(create: (_) => Recipes())
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child) {
          final themeProvider = Provider.of<DarkThemeProvider>(context);

          return MaterialApp(
              title: 'Flutter Demo',
              theme: themeProvider.getTheme(),
              debugShowCheckedModeBanner: false,
              home: SplashScreen(
                logedin: widget.logedin,
              ));
        },
        // child:
      ),
    );
  }
}
