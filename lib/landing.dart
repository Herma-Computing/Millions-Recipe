import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:millions_recipe/common/constants.dart';
import 'package:millions_recipe/newhome.dart';
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
    NewHome(),
    RecipesPage(),
    AddRecipe(),
    Favourites(),
    Profile(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = NewHome();

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
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x262E2E2E),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 8.0,
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
              icon: Icon(
                Icons.add,
                color: Colors.transparent,
              ),
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
      ),
    );
  }
}
