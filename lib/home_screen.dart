
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:millions_recipe/constants.dart';
import 'package:millions_recipe/screens/detail_screen.dart';
import 'package:millions_recipe/shared.dart';
import './providers/recipe_provider.dart';
import 'package:provider/provider.dart';
import './models/meal_model.dart';
import './providers/meal_provider.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import './widgets/post.dart';
// import './widgets/post_item.dart';
import 'models/recipe_model.dart';
import 'package:provider/provider.dart';
import './providers/recipe_provider.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {

 final _numberOfPostsPerRequest = 10;

  final PagingController<int, Recipe> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      // _fetchPage(pageKey);
      _fetchRecipe(pageKey);
    });
    super.initState();
  }

  // Future<void> _fetchPage(int pageKey) async {
  //   try {
  //     final response = await get(Uri.parse(
  //         "https://jsonplaceholder.typicode.com/posts?_page=$pageKey&_limit=$_numberOfPostsPerRequest"));
  //     List responseList = json.decode(response.body);
  //     List<Post> postList = responseList.map((data) =>
  //         Post(data['title'], data['body'])).toList();
  //     final isLastPage = postList.length < _numberOfPostsPerRequest;
  //     if (isLastPage) {
  //       _pagingController.appendLastPage(postList);
  //     } else {
  //       final nextPageKey = pageKey + 1;
  //       _pagingController.appendPage(postList, nextPageKey);
  //     }
  //   } catch (e) {
  //     print("error --> $e");
  //     _pagingController.error = e;
  //   }
  // }

  Future<void> _fetchRecipe(int pageKey) async {
    try {

    } catch(e){
      print("error -> $e");
      _pagingController.error = e;
    }
    List<Recipe> recipes = [];
    String currentPage = pageKey.toString();
    final recipeProv = Provider.of<Recipes>(context, listen: false);

    // if(widget.query != ""){
    //    await recipeProv.getRecipeApis(currentPage, widget.query);
    // } else {

    //    await recipeProv.getRecipeApis(currentPage, "");
    // }

   
    recipeProv.recipeList.forEach((element) { 
      recipes.add(element);
    });
    // String url = "https://datascienceplc.com/api/ds_her/v1/recipe/popular?page=$currentPage&per_page=15&category=bread";
    // Dio dio = Dio();
    // final response = await dio.get(url);
    // Recipe recipe;
    // response.data["recipes"].forEach((el) async => {
    //   recipe = Recipe.fromJson(el),
    //   recipes.add(recipe)
    // });

    final isLastPage = recipes.length < _numberOfPostsPerRequest;
    if(isLastPage){
      _pagingController.appendLastPage(recipes);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(recipes, nextPageKey);
    }
  }

  // Future fetchRecipes() async {


  // _loading = true;
  // recipes.clear();
  // String url = "https://datascienceplc.com/api/ds_her/v1/recipe/popular?page=1&per_page=15&category=bread";


  // Dio dio = Dio();
  // final response = await dio.get(url);

  // // var result = jsonDecode(response.data);

  // Recipe recipe;
  // response.data["recipes"].forEach((el) async => {
  //   recipe = Recipe.fromJson(el),
  //   recipes.add(recipe),

  // });


  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<Recipes>(context);
      return Consumer<Recipes>(builder: (context, recipe, child){

        return recipeProvider.apiLoading ? CircularProgressIndicator() : RefreshIndicator(
          onRefresh: () => Future.sync(() => _pagingController.refresh()),
          child: PagedListView<int, Recipe>(
            pagingController: _pagingController,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            builderDelegate: PagedChildBuilderDelegate<Recipe>(
              itemBuilder: (context, item, index) =>
                  GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                      meal: item)),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(16, 5, 16, 5 ),
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
                                       item
                                              .images
                                              .isNotEmpty
                                          ? 
                                          item.images[0].url
                                          : "https://cdn.dribbble.com/users/1013019/screenshots/3281397/media/9de100ad01c34ec34d35e843d33504f9.jpg?compress=1&resize=400x300"
                                           ,fit: BoxFit.contain
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
                                            item.name),
                                        buildRecipeSubTitle(
                                            item.description),
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
                                                 item.nutritions[0].value + "  " + item.nutritions[0].unit),
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
                          ))
      
            ),
      
          ),
        );
      }
        
      );
}

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
