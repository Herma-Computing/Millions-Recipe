// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:millions_recipe/common/constants.dart';
import 'package:provider/provider.dart';

import '../models/recipe_model.dart';
import '../providers/recipe_provider.dart';
import 'foodDetails/details.dart';

class SearchResult extends StatefulWidget {
  String query;
  SearchResult({super.key, required this.query});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  bool loading = false;
  void fetchSearch() {
    final recipeProvider = Provider.of<Recipes>(context, listen: false);
    recipeProvider.fetchRecipesBySearch(widget.query);
  }

  Future<void> searchAgain(String query) async {
    final recipeProvider = Provider.of<Recipes>(context, listen: false);
    setState(() {
      loading = true;
    });

    recipeProvider.fetchRecipesBySearch(query);

    setState(() {
      loading = false;
    });
  }

  Future<void> update() async {
    final recipeProvider = Provider.of<Recipes>(context, listen: false);
    recipeProvider.refreshFavoriteRecipes();
  }

  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    fetchSearch();
    update();
    _searchController.text = widget.query;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<Recipes>(context);
    final searchResults = recipeProvider.searchedRecipes;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        // title: IconButton(
        //     color: Colors.black,
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: Icon(Icons.keyboard_arrow_left)),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
          child: Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Container(
                height: 44,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 1, color: const Color(0xffD9D9D9))),
                child: TextField(
                  controller: _searchController,
                  onSubmitted: (value) {
                    setState(() {
                      loading = true;
                    });
                    searchAgain(value);
                    setState(() {
                      loading = false;
                    });
                  },
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
              // topSearchBar(_searchController),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "${recipeProvider.totalQuery} Recipes found",
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
        Consumer<Recipes>(
          builder: (context, value, child) {
            return Expanded(
              child: recipeProvider.loading
                  ? Center(
                      child: CircularProgressIndicator(
                      strokeWidth: 4,
                      color: kPrimaryColor,
                    ))
                  : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        bool isFavorited = recipeProvider.favList
                            .contains(searchResults[index].slug);
                        return Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child:
                              resuableCard(searchResults[index], isFavorited),
                        );
                      },
                    ),
            );
          },
        ),
      ]),
    );
  }

  Expanded resuableCard(Recipe recipe, bool isFavorited) {
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
              Align(
                alignment: Alignment(1, -1),
                child: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border_rounded,
                  color: isFavorited ? Colors.red : Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                      width: 128,
                      height: 155,
                      child: Image.network(recipe.images[0].url)),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        reusableRow(
                            "${recipe.serving} people", Icons.people_outline),
                        reusableRow(recipe.total_time, Icons.access_time),
                        reusableRow("${recipe.nutritions[1].value}kcal",
                            CupertinoIcons.flame),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FoodDetails(meal: recipe),
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

Widget topSearchBar(TextEditingController controller, Function searchAgain) {
  return Container(
    height: 44,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: const Color(0xffD9D9D9))),
    child: TextField(
      controller: controller,
      onSubmitted: (value) {
        // searchAgain(value);
      },
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
  );
}
