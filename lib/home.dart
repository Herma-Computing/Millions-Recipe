import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:millions_recipe/common/constants.dart';
import 'package:millions_recipe/providers/recipe_provider.dart';
import 'package:millions_recipe/common/shared.dart';
import 'package:provider/provider.dart';

import 'models/recipe_model.dart';
import 'widgets/foodDetails/details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<bool> optionSelected = [false, false, false];
  String category = "Bread";
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
  bool isCategorySelecting = false;

  bool isSearching = false;
  String searchQuery = "";
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  List<Recipe> result = [];
  ScrollController scrollController = ScrollController();
  ScrollController sController = ScrollController();
  bool loading = true;
  int offset = 0;
  int currentPage = 1;
  @override
  void initState() {
    super.initState();
    fetchData(offset, "");
    final recipeProvider = Provider.of<Recipes>(context, listen: false);
    recipeProvider.fetchRecipesByCategory("Main Dishes");
    handleNext();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    searchFocusNode.dispose();
  }

  void fetchData(paraOffset, String query) async {
    setState(() {
      loading = true;
    });

    if (isSearching || isCategorySelecting) {
      result.clear();
    }
    List<Recipe> recipeList = [];
    final recipeProvider = Provider.of<Recipes>(context, listen: false);
    await recipeProvider.getRecipeApis(
        currentPage.toString(), query, category, isSearching);
    recipeList = recipeProvider.recipeList;
    // response.data["recipes"].forEach(
    //     (el) async => {recipe = Recipe.fromJson(el), recipeList.add(recipe)});

    result = result + recipeList;
    int localOffset = offset + 15;
    if (!isSearching) {
      currentPage++;
    }
    setState(() {
      result;
      loading = false;
      offset = localOffset;
      isCategorySelecting = false;
    });
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        fetchData(offset, searchQuery);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<Recipes>(context);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
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
              isSearching
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: TextField(
                        controller: searchController,
                        onChanged: ((value) => {
                              searchQuery = searchController.text,
                              fetchData(offset, searchQuery)
                            }),
                        focusNode: searchFocusNode,
                      ),
                    )
                  : const SizedBox(),
              Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: IconButton(
                    onPressed: () => setState(() {
                      if (isSearching) {
                        setState(() {
                          isSearching = false;
                          // searchFocusNode.unfocus();
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
                  .map((selectedCategory) => ListTile(
                        title: Text(selectedCategory),
                        onTap: (() => setState(() {
                              category = selectedCategory;
                              isCategorySelecting = true;
                              fetchData(offset, searchQuery);
                              recipeProvider.fetchRecipesByCategory(category);

                              Navigator.pop(context);
                            })),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
      body: ListView(
        controller: scrollController,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextTitleVariation1(category),
                buildTextSubTitleVariation1(
                    'Healthy and nutritious food recipes'),
              ],
            ),
          ),
          isSearching
              ? const SizedBox()
              : const SizedBox(
                  height: 32,
                ),
          recipeProvider.subCategoryLoading
              ? const SizedBox()
              :
              // Row(

              //   // should be changed to list view to support horizontal scroll
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: recipeProvider.subCategories.map((e) => option(e.name)).toList()
              // ),
              !isSearching
                  ? Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: recipeProvider.subCategories.length,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return option(
                                recipeProvider.subCategories[index].name);
                          }),
                    )
                  : const SizedBox(),
          const SizedBox(
            height: 24,
          ),
          isSearching
              ? const SizedBox()
              : Container(
                  // width: 50,
                  height: 350,
                  child: Consumer<Recipes>(
                    builder: (context, fs, child) {
                      return Container(
                        child: recipeProvider.loading
                            ? const Center(
                                child: CircularProgressIndicator(
                                strokeWidth: 4,
                              ))
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
                                            builder: (context) =>
                                                // DetailScreen(meal: recipeProvider.recipes[index])),
                                                FoodDetails(
                                                    meal: recipeProvider
                                                        .recipes[index])),
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
                                            child: Container(
                                              width: 180,
                                              height: 180,
                                              child: Image.network(
                                                recipeProvider.recipes[index]
                                                        .images.isNotEmpty
                                                    ? recipeProvider
                                                        .recipes[index]
                                                        .images[0]
                                                        .url
                                                    : "https://cdn.dribbble.com/users/1013019/screenshots/3281397/media/9de100ad01c34ec34d35e843d33504f9.jpg?compress=1&resize=400x300",
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          buildRecipeTitle(recipeProvider
                                              .recipes[index].name),
                                          buildTextSubTitleVariation2(
                                              recipeProvider
                                                  .recipes[index].description),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              buildCalories(recipeProvider
                                                  .recipes[index]
                                                  .nutritions[0]
                                                  .value),
                                              // const Icon(
                                              //   Icons.favorite_border,
                                              // )
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
                ),
          Consumer<Recipes>(builder: (context, value, child) {
            return ListView.builder(
                controller: sController,
                shrinkWrap: true,
                itemCount: result.length + 1,
                itemBuilder: (context, index) {
                  if (index == result.length) {
                    return loading
                        ? Container(
                            height: 200,
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 4,
                              ),
                            ),
                          )
                        : Container();
                  }
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  // DetailScreen(meal: result[index])),
                                  FoodDetails(
                                      meal: recipeProvider.recipes[index])),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [kBoxShadow],
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              height: 160,
                              width: 160,
                              child: Image.network(
                                  result[index].images.isNotEmpty
                                      ? result[index].images[0].url
                                      : "https://cdn.dribbble.com/users/1013019/screenshots/3281397/media/9de100ad01c34ec34d35e843d33504f9.jpg?compress=1&resize=400x300",
                                  fit: BoxFit.contain),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buildRecipeTitle(result[index].name),
                                    buildRecipeSubTitle(
                                        result[index].description),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          buildCalories(result[index]
                                              .nutritions[0]
                                              .value),
                                          // Icon(
                                          //   Icons.favorite_border,
                                          // )
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
                });
          })
        ],
      ),
    );
  }

  Widget option(String text) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [kBoxShadow],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
