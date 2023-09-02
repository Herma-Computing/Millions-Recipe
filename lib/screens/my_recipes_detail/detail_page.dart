import 'dart:io';

import 'package:flutter/material.dart';

import '../cook_step/cooking_step_my_recipe.dart';
import 'Description/description.dart';
import 'Diet/diet.dart';
import 'ingredients_page/ingredientpage.dart';
import 'nutration/nutration.dart';

// ignore: must_be_immutable
class RecipeDetail extends StatefulWidget {
  dynamic recipesData;
  List recipesImage;
  dynamic recipeIngrident;
  dynamic recipeStep;
  RecipeDetail(
      {Key? key,
      required this.recipesData,
      required this.recipesImage,
      required this.recipeIngrident,
      required this.recipeStep})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  final PageController _pageController = PageController(initialPage: 0);
  int pageviewSelected = 0;
  int currentImageIndex = 0;

  List<Widget> pages = [];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      MyIngredient(ingredient: widget.recipeIngrident),
      const MyNutration(),
      const MyDiet(),
    ];
    Color black = const Color.fromARGB(115, 46, 46, 46);
    Color green = Colors.green;
    Color white = const Color(0xFFFFFFFF);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: PageView.builder(
                      itemCount: widget.recipesImage.length,
                      onPageChanged: (int index) {
                        setState(() {
                          currentImageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return widget.recipesImage.isNotEmpty &&
                                widget.recipesImage[index].startsWith("http")
                            ? Image.network(
                                widget.recipesImage[index],
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(widget.recipesImage[index]),
                                fit: BoxFit.cover,
                              );
                      },
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 15,
                    right: 15,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        iconButton(
                          white,
                          black,
                          Icons.arrow_back,
                          () => Navigator.pop(context),
                        ),
                        iconButton(
                          white,
                          black,
                          Icons.favorite_border_outlined,
                          () => {},
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      '${currentImageIndex + 1}/${widget.recipesImage.length}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 21),
                      child: Text(
                        "${widget.recipesData['name']}",
                        style: const TextStyle(
                          fontSize: 21,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: methdOfmenu(
                                  false,
                                  black,
                                  Icons.group_outlined,
                                  () => {},
                                  "${widget.recipesData['serving']} people"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: methdOfmenu(
                                  false,
                                  black,
                                  Icons.access_time_outlined,
                                  () => {},
                                  "${widget.recipesData['total_time']}"),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: methdOfmenu(
                                    false,
                                    black,
                                    Icons.egg_outlined,
                                    () => {},
                                    // "${widget.meal.nutritions[1].value}kcal"
                                    "350Kcal"),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: methdOfmenu(true, green, Icons.check_box,
                                    () => {}, "You have all the ingredients"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Descriptions(recipesData: widget.recipesData),
              const SizedBox(
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  children: [
                    Expanded(
                      child:
                          pageViewTextButton(0, "Ingredients", true, green, () {
                        _pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }),
                    ),
                    Expanded(
                      child:
                          pageViewTextButton(1, "Nutrition", false, green, () {
                        _pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }),
                    ),
                    Expanded(
                      child:
                          pageViewTextButton(2, "Categories", false, green, () {
                        _pageController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 450,
                child: Expanded(
                  child: PageView(
                    onPageChanged: (int index) {
                      setState(() {
                        pageviewSelected = index;
                      });
                    },
                    controller: _pageController,
                    children: pages,
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => CookingSteps(
                          recipeStep: widget.recipeStep,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 250,
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Show cooking steps",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToPage(int index) {
    if (index >= 0 && index < pages.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Container iconButton(
      Color white, Color black, IconData icon, GestureTapCallback x) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(shape: BoxShape.circle, color: white),
      child: Center(
        child: IconButton(
          onPressed: x,
          icon: Icon(icon, color: Colors.black),
        ),
      ),
    );
  }

  Row methdOfmenu(bool isSelected, Color color, IconData icon,
      GestureTapCallback x, String title) {
    return Row(
      children: [
        GestureDetector(
          onTap: x,
          child: Icon(icon,
              color: isSelected == true
                  ? color
                  : Theme.of(context).colorScheme.secondary),
        ),
        Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
      ],
    );
  }

  GestureDetector pageViewTextButton(int index, String title, bool isSelected,
      Color green, GestureTapCallback function) {
    return GestureDetector(
      onTap: function,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: pageviewSelected == index ? green : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: 100,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: pageviewSelected == index ? green : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
