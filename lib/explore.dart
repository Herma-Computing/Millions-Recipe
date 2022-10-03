import 'dart:convert';

import 'package:flutter/material.dart';
import './providers/recipe_provider.dart';
import 'package:provider/provider.dart';
import './constants.dart';
import './data.dart';
import './detail.dart';
import './shared.dart';
import './models/meal_model.dart';
import './providers/meal_provider.dart';
import './screens/detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<bool> optionSelected = [false, false, false];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final recipeModel = Provider.of<Recipes>(context, listen: false);
    recipeModel.fetchRecipes();
  }

  String selectedCategory = '';
  List<String> catgories = [
    'Bread',
    'Breakfast and Brunch',
    'Appetizers and Snacks',
    'Main Dishes',
    'Meat and Poultry',
    'Everyday Cooking',
    'Desserts',
    'Fruits and Vegetables',
    'Side Dish',
    'Drink Recipes',
    'Pasta and Noodles,'
        'Salad',
    'Holidays and Events Recipes',
    'Seafood',
    'Soups, Stews and Chili Recipes',
  ];

  bool isSearching = false;
  String searchQuery = 'a';

  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  Widget drawerListTile(String element) {
    Widget listTile = ListTile(
      title: Text(element),
      onTap: () {
        setState(() {
          selectedCategory = element;
        });
      },
    );
    return listTile;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<Recipes>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        // InkWell(
        //   onTap: (){
        //      Scaffold.of(context).openDrawer();
        //   },
        //           child: Icon(
        //     Icons.menu,
        //     size: appBarMenuIconSize,
        //   ),
        // ),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            // drawer
            icon: const Icon(Icons.dehaze),
            color: Colors.black,
          ),
        ),

        actions: [
          Row(
            children: [
              recipeProvider.loading
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: TextField(
                        controller: searchController,
                        onChanged: ((value) => setState(() {
                              searchQuery = searchController.text;
                              if (searchQuery == '') {
                                searchQuery = 'a';
                              }
                            })),
                        focusNode: searchFocusNode,
                      ),
                    )
                  : SizedBox(),
              Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: IconButton(
                    onPressed: () => setState(() {
                      if (isSearching) {
                        setState(() {
                          isSearching = false;
                          searchFocusNode.unfocus();
                        });
                      } else {
                        isSearching = true;
                      }
                    }),
                    icon: isSearching
                        ? const Icon(
                            Icons.close,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                  )),
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: catgories
                  .map((category) => ListTile(
                        title: Text(category),
                        onTap: (() => setState(() {
                              selectedCategory = category;
                              recipeProvider.fetchRecipesByCategory(category);
                              Navigator.pop(context);
                            })),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation1(selectedCategory),
                  buildTextSubTitleVariation1(
                      'Healthy and nutritious food recipes'),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    // should be changed to list view to support horizontal scroll
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      option('Vegetable', 'assets/icons/salad.png', 0),
                      const SizedBox(
                        width: 8,
                      ),
                      option('Rice', 'assets/icons/rice.png', 1),
                      const SizedBox(
                        width: 8,
                      ),
                      option('Fruit', 'assets/icons/fruit.png', 2),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              // width: 50,
              height: 350,
              child: Consumer<Recipes>(
                builder: (context, recipe, child) {
                  return Container(
                    child: recipeProvider.loading
                        ? const LoadingIndicator(
                          indicatorType: Indicator.lineSpinFadeLoader,

                          /// Required, The loading type of the widget
                          colors: [Colors.black],

                          /// Optional, The color collections
                          strokeWidth: 2,

                          /// Optional, The stroke of the line, only applicable to widget which contains line
                          backgroundColor: Colors.white,

                          /// Optional, Background of the widget
                          pathBackgroundColor: Colors.black

                          /// Optional, the stroke backgroundColor
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: recipeProvider.recipes.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            meal:
                                                recipe.recipes[index])),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    boxShadow: [kBoxShadow],
                                  ),
                                  margin: EdgeInsets.only(
                                      right: 16,
                                      left: index == 0 ? 16 : 0,
                                      bottom: 16,
                                      top: 8),
                                  padding: const EdgeInsets.all(16),
                                  width: 220,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.network(
                                          recipe
                                                .recipes[index]
                                                .images
                                                .isNotEmpty
                                            ? 
                                            recipe
                                                .recipes[index].images[0].url
                                            : "https://cdn.dribbble.com/users/1013019/screenshots/3281397/media/9de100ad01c34ec34d35e843d33504f9.jpg?compress=1&resize=400x300"
                                             ,fit: BoxFit.cover,),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      buildRecipeTitle(
                                          recipe.recipes[index].name),
                                      buildTextSubTitleVariation2(recipe
                                          .recipes[index].description),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          buildCalories( recipe.recipes[index].nutritions[0].value + "  " + recipe.recipes[index].nutritions[0].unit),
                                          const Icon(
                                            Icons.favorite_border,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  );
                },
              ),
              // child: FutureBuilder<List<RecipeMeal>?>(
              //   future: getTestJson(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData &&
              //         snapshot.connectionState == ConnectionState.done) {
              //       // print(snapshot.data[index]);
              //       return ;
              //     }

              //     /// handles others as you did on question
              //     else {
              //       return Container(
              //         height: 100,
              //         width: 100,
              //         child: const LoadingIndicator(
              //             indicatorType: Indicator.lineSpinFadeLoader,

              //             /// Required, The loading type of the widget
              //             colors: [Colors.black],

              //             /// Optional, The color collections
              //             strokeWidth: 2,

              //             /// Optional, The stroke of the line, only applicable to widget which contains line
              //             backgroundColor: Colors.white,

              //             /// Optional, Background of the widget
              //             pathBackgroundColor: Colors.black

              //             /// Optional, the stroke backgroundColor
              //             ),
              //       );
              //     }
              //   },
              // ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  buildTextTitleVariation2('Popular', false),
                  SizedBox(
                    width: 8,
                  ),
                  buildTextTitleVariation2('Food', true),
                ],
              ),
            ),
            // Container(
            //   height: 190,
            //   child: PageView(
            //     physics: BouncingScrollPhysics(),
            //     children: buildPopulars(),
            //   ),
            // ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: Container(
                  child: Consumer<Recipes>(builder: (context, recipe, child) {
                    return !recipeProvider.loading ? ListView.builder(
                        // physics: BouncingScrollPhysics(),
                        // scrollDirection: Axis.horizontal,
                        itemCount: recipeProvider.recipes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                          meal: recipe.recipes[index])),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  boxShadow: [kBoxShadow],
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      height: 160,
                                      width: 160,
                                      child: Image.network(
                                          recipe.recipes[index].images[0].url
                                         ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            buildRecipeTitle(
                                                recipe.recipes[index].name),
                                            buildRecipeSubTitle(
                                                recipe.recipes[index].description),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  buildCalories(
                                                     recipe.recipes[index].nutritions[0].value + "  " + recipe.recipes[index].nutritions[0].unit),
                                                  Icon(
                                                    Icons.favorite_border,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ) : Container(child:const LoadingIndicator(
                          indicatorType: Indicator.lineSpinFadeLoader,

                          /// Required, The loading type of the widget
                          colors: [Colors.black],

                          /// Optional, The color collections
                          strokeWidth: 2,

                          /// Optional, The stroke of the line, only applicable to widget which contains line
                          backgroundColor: Colors.white,

                          /// Optional, Background of the widget
                          pathBackgroundColor: Colors.black

                          /// Optional, the stroke backgroundColor
                          ),);
                  } ,),
                )
                
              ),
            ),
            // Container(
            //   height: 350,
            //   child: ListView(
            //     physics: BouncingScrollPhysics(),
            //     scrollDirection: Axis.horizontal,
            //     children: buildRecipes(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget option(String text, String image, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          optionSelected[index] = !optionSelected[index];
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: optionSelected[index] ? kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [kBoxShadow],
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            SizedBox(
              height: 32,
              width: 32,
              child: Image.asset(
                image,
                color: optionSelected[index] ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: TextStyle(
                color: optionSelected[index] ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildRecipes() {
    List<Widget> list = [];
    for (var i = 0; i < getRecipes().length; i++) {
      list.add(buildRecipe(getRecipes()[i], i));
    }
    return list;
  }

  Widget buildRecipe(Recipe recipe, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(recipe: recipe)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [kBoxShadow],
        ),
        margin: EdgeInsets.only(
            right: 16, left: index == 0 ? 16 : 0, bottom: 16, top: 8),
        padding: EdgeInsets.all(16),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Container(
              child: Image.network(recipe.image),
            )),
            SizedBox(
              height: 8,
            ),
            buildRecipeTitle(recipe.title),
            buildTextSubTitleVariation2(recipe.description),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCalories(recipe.calories.toString() + " Kcal"),
                Icon(
                  Icons.favorite_border,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  // List<Widget> buildMeals() {
  //   List<Widget> list = [];
  //   for (var i = 0; i < fetchMeals().length; i++) {
  //     list.add(buildRecipe(getRecipes()[i], i));
  //   }
  //   return list;
  // }

  Widget buildMeal(Meal meal, int index) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Detail(recipe: meal)),
        // );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [kBoxShadow],
        ),
        margin: EdgeInsets.only(
            right: 16, left: index == 0 ? 16 : 0, bottom: 16, top: 8),
        padding: EdgeInsets.all(16),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Container(
              child: Image.network(meal.strMealThumb),
            )),
            SizedBox(
              height: 8,
            ),
            buildRecipeTitle(meal.strMeal),
            buildTextSubTitleVariation2("meal description"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCalories('80' + " Kcal"),
                Icon(
                  Icons.favorite_border,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildPopulars() {
    List<Widget> list = [];
    for (var i = 0; i < getRecipes().length; i++) {
      list.add(buildPopular(getRecipes()[i]));
    }
    return list;
  }

  Widget buildPopular(Recipe recipe) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [kBoxShadow],
      ),
      child: Row(
        children: [
          Container(
            height: 160,
            width: 160,
            child: Image.network(recipe.image),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildRecipeTitle(recipe.title),
                  buildRecipeSubTitle(recipe.description),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildCalories(recipe.calories.toString() + " Kcal"),
                      Icon(
                        Icons.favorite_border,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
