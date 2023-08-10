// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import 'my_recipes_detail/detail_page.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({Key? key}) : super(key: key);
  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  int _numberOfSavedRecipes = 0;
  final List<Map<String, dynamic>> _recipesData = [];
  final List<List<String>> _imageUrls = [];
  final List<Map<String, dynamic>> _ingredients = [];
  final List<Map<String, dynamic>> _cookSteps = [];

  void _fetchData() async {
    try {
      final db = await SqlHelper.db();

      final savedRecipes = await db.rawQuery('SELECT COUNT(*) FROM recipes');
      setState(() {
        _numberOfSavedRecipes = Sqflite.firstIntValue(savedRecipes) ?? 0;
      });

      final recipeData = await db.rawQuery('SELECT * FROM recipes');
      final imageData = await db.rawQuery('SELECT * FROM recipe_images');
      final ingredients = await db.rawQuery('SELECT * FROM ingredients');
      final cookingSteps = await db.rawQuery('SELECT * FROM steps');

      setState(() {
        _recipesData.clear();
        _recipesData.addAll(recipeData);

        _imageUrls.clear();
        for (final data in imageData) {
          final imageUrlJson = data['img_url'] as String?;
          if (imageUrlJson != null) {
            final List<dynamic> imageUrlList = jsonDecode(imageUrlJson);
            final List<String> imageUrls =
                imageUrlList.map((imageUrl) => imageUrl as String).toList();
            _imageUrls.add(imageUrls);
          }
        }

        _ingredients.clear();

        for (final data in ingredients) {
          _ingredients.add(data);
        }

        _cookSteps.clear();

        for (final data in cookingSteps) {
          _cookSteps.add(data);
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 26),
          child: Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: topSearchBar(),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "$_numberOfSavedRecipes Recipes found",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _recipesData.length,
            itemBuilder: (context, index) {
              final recipeData = _recipesData[index];
              final recipeName = recipeData['name'] as String;
              final recipeImage = _imageUrls[index];
              final recipeIngredient = _ingredients[index];

              final recipeSteps = _cookSteps[index];

              return Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: recipeName != null && recipeImage != null
                    ? resuableCard(
                        recipeName,
                        recipeImage,
                        "${recipeData['serving']}",
                        "${recipeData['total_time']}",
                        recipeData,
                        recipeIngredient,
                        recipeSteps)
                    : Text("No Data!!"),
              );
            },
          ),
        )
      ]),
    );
  }

  Expanded resuableCard(String recipeName, List imageUrl, String serving,
      String totalTime, var recipesData, var ingredient, var cookSteps) {
    Widget imageWidget;

    if (imageUrl.isNotEmpty && imageUrl[0].startsWith('http')) {
      imageWidget = Image.network(imageUrl[0]);
    } else if (imageUrl.isNotEmpty) {
      imageWidget = Image.file(File(imageUrl[0]));
    } else {
      imageWidget = Image.asset('assets/pancake.png');
    }
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.only(left: 22, right: 30),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
          padding: const EdgeInsets.all(11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment(1, -1),
                child: Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.red,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 128,
                    height: 155,
                    child: imageWidget,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipeName,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        reusableRow("$serving people", Icons.people_outline),
                        reusableRow(totalTime, Icons.access_time),
                        reusableRow("350kcal", CupertinoIcons.flame),
                        Row(
                          children: const [
                            // Checkbox(
                            //   activeColor: Color(0xff53E88B),
                            //   value: true,
                            //   onChanged: (value) {},
                            // ),

                            Icon(
                              Icons.check_box_outlined,
                              color: Color(0xff53E88B),
                            ),

                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: Text(
                                "You have all the ingredients",
                                style: TextStyle(
                                    color: Color(0xff53E88B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecipeDetail(
                              recipesData: recipesData,
                              recipesImage: imageUrl,
                              recipeIngrident: ingredient,
                              recipeStep: cookSteps,
                            )),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: 208.47,
                  height: 44,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Color(0xff15BE77),
                          Color(0xff53E88B),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "Show Recipe",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row reusableRow(String txt, IconData ico) {
    return Row(
      children: [
        Icon(ico),
        const SizedBox(
          width: 8,
        ),
        Text(
          txt,
          style: const TextStyle(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

Widget topSearchBar() {
  return Container(
    height: 44,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: const Color(0xffD9D9D9))),
    child: TextField(
      cursorColor: Colors.blueAccent,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Color(0xffD9D9D9),
        ),
        hintText: "Search recipes",
        hintStyle: TextStyle(color: Color(0xffC1C1C1)),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        isDense: true,
        suffixIcon: Icon(
          CupertinoIcons.slider_horizontal_3,
          color: Color(0xffD9D9D9),
        ),
      ),
    ),
  );
}
