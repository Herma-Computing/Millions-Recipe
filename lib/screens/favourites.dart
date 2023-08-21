import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:millions_recipe/widgets/foodDetails/details.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';

import '../models/recipe_model.dart';
import '../providers/recipe_provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({
    super.key,
  });
  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  Future<void> fetchRecipes() async {
    final recipeProvider = Provider.of<Recipes>(context, listen: false);
    await recipeProvider.fetchRecipe();
    // await recipeProvider.refreshFavoriteRecipes();
  }

  @override
  void initState() {
    // _fetchData();
    fetchRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<Recipes>(context);

    bool loading = recipeProvider.favLoading;
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(left: 20, top: 50, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 44,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: const Color(0xffD9D9D9))),
            child: TextField(
              cursorColor: kPrimaryColor,
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
          ),
          Text(
            '${recipeProvider.favoriteRecipes.length} Recieps found',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Consumer<Recipes>(
            builder: (context, value, child) {
              return Expanded(
                  child: recipeProvider.favLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            color: kPrimaryColor,
                          ),
                        )
                      : ListView.builder(
                          itemCount: recipeProvider.favoriteRecipes.length,
                          itemBuilder: (context, index) {
                            Recipe recipe =
                                recipeProvider.favoriteRecipes[index];

                            return loading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 4,
                                      color: kPrimaryColor,
                                    ),
                                  )
                                : recipeCard(context, recipe, fetchRecipes);
                          }));
            },
          )
        ],
      ),
    ));
  }
}

Widget recipeCard(BuildContext context, Recipe recipe, Function fetchRecipe) {
  return Stack(
    children: [
      Card(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 35, left: 13, bottom: 14, right: 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 130,
                    width: 127,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Image.network(
                      recipe.images[0].url,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            recipe.name,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Row(children: [
                            const Icon(Icons.group),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${recipe.serving} people',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 10),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Row(children: [
                            const Icon(Icons.timer),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              recipe.total_time,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 10),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Row(children: [
                            const Icon(Icons.rice_bowl),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${recipe.nutritions[1].value} kcl",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 10),
                            ),
                          ]),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Row(children: [
                            Icon(
                              Icons.check_box_outlined,
                              color: Color(0xff53E88B),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'You have all the ingedients',
                              style: TextStyle(
                                  color: Color(0xff53E88B), fontSize: 10),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  fetchRecipe();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => FoodDetails(
                        meal: recipe,
                      ),
                    ),
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
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: 10,
        right: 3,
        child: Container(
          margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
          padding: const EdgeInsets.all(5.0),
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            color: Color(0xffE23E3E),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            'assets/allSVG/Favorite-Icon.svg',
            // ignore: deprecated_member_use
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}
