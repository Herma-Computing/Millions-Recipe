import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:millions_recipe/common/constants.dart';
import 'package:millions_recipe/home.dart';
import 'package:millions_recipe/screens/add_recipe.dart';
import 'package:millions_recipe/screens/favourites.dart';
import 'package:millions_recipe/screens/profile.dart';
import 'package:millions_recipe/screens/recipesPage.dart';

class Landing extends StatefulWidget {
  Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int currentTab = 0;

  final List<Widget> screens = [
    Home(),
    RecipesPage(),
    AddRecipe(),
    Favourites(),
    Profile(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[50],
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
        backgroundColor: const Color(0xff53E88B),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kActiveColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab,
        onTap: (int index) {
          setState(() {
            currentTab = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/allSVG/Home-Icon.svg',
              color: kActiveColor,
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
              color: kActiveColor,
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
            icon: Icon(Icons.add),
            label: "Add Recipe",
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/allSVG/Favorite-Icon.svg',
              color: kActiveColor,
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
              color: kActiveColor,
            ),
            icon: Opacity(
              opacity: 0.25,
              child: SvgPicture.asset(
                'assets/allSVG/Profile-Icon.svg',
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
