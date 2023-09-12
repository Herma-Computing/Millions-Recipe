import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:millions_recipe/common/constants.dart';
import 'package:millions_recipe/newhome.dart';
import 'package:millions_recipe/providers/theme_provider.dart';
import 'package:millions_recipe/screens/add_recipe.dart';
import 'package:millions_recipe/screens/favourites.dart';
import 'package:millions_recipe/screens/profile/profile.dart';
import 'package:millions_recipe/screens/recipes_page.dart';
import 'package:provider/provider.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int currentTab = 0;

  final List<Widget> screens = [
    const NewHome(),
    const RecipesPage(),
    const AddRecipe(),
    const Favourites(),
    const Profile(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const NewHome();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      // backgroundColor: Colors.white,
      // Colors.grey[50],
      body: PageStorage(
        bucket: bucket,
        child: screens[currentTab],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentTab = 2;
          });
        },
        tooltip: "Add Recipe",
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kActiveColor, kGradientColorTo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          // boxShadow: [
          //   BoxShadow(
          //     color: Theme.of(context).colorScheme.onSecondaryContainer,
          //     spreadRadius: 1,
          //     blurRadius: 10,
          //     offset: Offset(0, 3),
          //   ),
          // ],
        ),
        child: Consumer<DarkThemeProvider>(builder: (context, value, child) {
          final themeProvider = Provider.of<DarkThemeProvider>(context);
          return BottomNavigationBar(
              elevation: 8.0,
              selectedItemColor: kActiveColor,
              unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentTab,
              onTap: (int index) {
                setState(() {
                  currentTab = index;
                });
              },
              items: themeProvider.isDarkMode
                  ? [
                      BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          'assets/allSVG/Home-Icon.svg',
                          colorFilter: ColorFilter.mode(
                            kActiveColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        icon: Opacity(
                          opacity: 0.25,
                          child: SvgPicture.asset(
                            'assets/allSVG/home.svg',
                          ),
                        ),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          'assets/allSVG/My-Recipe-Icon.svg',
                          colorFilter: ColorFilter.mode(
                            kActiveColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        icon: Opacity(
                          opacity: 0.25,
                          child: SvgPicture.asset(
                            'assets/allSVG/Folder 1.svg',
                          ),
                        ),
                        label: "Recipes",
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(
                          Icons.add,
                          color: Colors.transparent,
                        ),
                        label: "Add Recipe",
                      ),
                      BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          'assets/allSVG/Favorite-Icon.svg',
                          colorFilter: ColorFilter.mode(
                            kActiveColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        icon: Opacity(
                          opacity: 0.25,
                          child: SvgPicture.asset(
                            'assets/allSVG/favorite.svg',
                          ),
                        ),
                        label: "Favourites",
                      ),
                      BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          'assets/allSVG/Profile-Icon.svg',
                          colorFilter: ColorFilter.mode(
                            kActiveColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        icon: Opacity(
                          opacity: 0.25,
                          child: SvgPicture.asset(
                            'assets/allSVG/User.svg',
                          ),
                        ),
                        label: "Profile",
                      ),
                    ]
                  : [
                      BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          'assets/allSVG/Home-Icon.svg',
                          colorFilter: ColorFilter.mode(
                            kActiveColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        icon: Opacity(
                          opacity: 0.25,
                          child: SvgPicture.asset(
                            'assets/allSVG/Home-Icon.svg',
                          ),
                        ),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          'assets/allSVG/My-Recipe-Icon.svg',
                          colorFilter: ColorFilter.mode(
                            kActiveColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        icon: Opacity(
                          opacity: 0.25,
                          child: SvgPicture.asset(
                            'assets/allSVG/My-Recipe-Icon.svg',
                          ),
                        ),
                        label: "Recipes",
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(
                          Icons.add,
                          color: Colors.transparent,
                        ),
                        label: "Add Recipe",
                      ),
                      BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          'assets/allSVG/Favorite-Icon.svg',
                          colorFilter: ColorFilter.mode(
                            kActiveColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        icon: Opacity(
                          opacity: 0.25,
                          child: SvgPicture.asset(
                            'assets/allSVG/Favorite-Icon.svg',
                          ),
                        ),
                        label: "Favourites",
                      ),
                      BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          'assets/allSVG/Profile-Icon.svg',
                          colorFilter: ColorFilter.mode(
                            kActiveColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        icon: Opacity(
                          opacity: 0.25,
                          child: SvgPicture.asset(
                            'assets/allSVG/Profile-Icon.svg',
                          ),
                        ),
                        label: "Profile",
                      ),
                    ]);
        }),
      ),
    );
  }
}
