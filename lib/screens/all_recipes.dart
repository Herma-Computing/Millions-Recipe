import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';
import '../models/recipe_model.dart';
import '../providers/recipe_provider.dart';
import '../widgets/foodDetails/details.dart';

class AllRecipes extends StatefulWidget {
  const AllRecipes({super.key});

  @override
  State<AllRecipes> createState() => _AllRecipesState();
}

class _AllRecipesState extends State<AllRecipes> {
  final ScrollController _controller = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    update();
    super.initState();
    _controller.addListener(_scrollListener);

    fetchRecipesByCategory('');
  }

  Future<void> update() async {
    final recipeProvider = Provider.of<Recipes>(context, listen: false);
    recipeProvider.refreshFavoriteRecipes();
  }

  List recipeList = [];

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.position.maxScrollExtent == _controller.offset &&
        !_isLoading) {
      fetchRecipesByCategory('');
    }
  }

  Future<void> fetchRecipesByCategory(String category) async {
    setState(() {
      _isLoading = true;
    });

    String url =
        "https://dashencon.com/recipes/api/ds_her/v1/recipes?page=1&per_page=15&category=$category";

    Dio dio = Dio();
    final response = await dio.get(url);

    Recipe recipe;
    response.data["random"].forEach(
        (el) async => {recipe = Recipe.fromJson(el), recipeList.add(recipe)});

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<Recipes>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: recipeList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView.builder(
                controller: _controller,
                itemCount: (recipeList.length ~/ 2) + 1,
                itemBuilder: (context, index) {
                  // update();
                  bool isFavorited =
                      recipeProvider.favList.contains(recipeList[index].slug);

                  if (index == recipeList.length ~/ 2) {
                    return _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container();
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        recipeCard(
                            recipeList[index].images.isNotEmpty
                                ? recipeList[index].images[0].url
                                : "https://cdn.dribbble.com/users/1013019/screenshots/3281397/media/9de100ad01c34ec34d35e843d33504f9.jpg?compress=1&resize=400x300",
                            recipeList[index].name,
                            recipeList[index].total_time,
                            recipeList[index].nutritions[1].value,
                            recipeList[index],
                            isFavorited),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          : _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    color: kPrimaryColor,
                  ),
                )
              : const Center(
                  child: Text(
                    'No Recipes Found',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
    );
  }

  Widget recipeCard(String pic, String mealName, String time, String calories,
      Recipe meal, bool isFavorited) {
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
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Image.network(pic),
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
                              mealName,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Row(
                              children: [
                                const Icon(Icons.people_alt_outlined),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${meal.serving} people',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Row(
                              children: [
                                const Icon(Icons.timer_outlined),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '$time min',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Row(
                              children: [
                                const Icon(CupertinoIcons.flame),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '$calories Kcal',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_box_outlined,
                                  color: Color(0xff53E88B),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    'You have all the ingredients',
                                    style: TextStyle(
                                        color: Color(0xff53E88B), fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    update();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDetails(meal: meal),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Show Detail",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
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
            decoration: BoxDecoration(
              color: isFavorited ? const Color(0xffE23E3E) : Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/allSVG/Favorite-Icon.svg',
              // ignore: deprecated_member_use
              color: isFavorited ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}