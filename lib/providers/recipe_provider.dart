import 'package:flutter/cupertino.dart';
import 'package:millions_recipe/models/sub_category.dart';
import 'package:provider/provider.dart';
import '../database/database_helper.dart';
import '../models/recipe_model.dart';
import 'package:dio/dio.dart';

class Recipes with ChangeNotifier {
  bool _loading = false;

  List<Recipe> recipes = [];
  List<Recipe> searchedRecipes = [];
  List<Recipe> favoriteRecipes = [];
  List favList = [];
  int totalQuery = 0;

  bool _favLoading = false;

  bool get favLoading => _favLoading;

  bool get loading => _loading;

  final bool _popularLoading = false;
  List<Recipe> popularRecipes = [];
  bool get popularLoading => _popularLoading;

  bool _apiLoading = false;
  List<Recipe> recipeList = [];
  bool get apiLoading => _apiLoading;

  bool _subCategoryLoading = false;
  List<SubCategory> subCategories = [];
  bool get subCategoryLoading => _subCategoryLoading;

  getRecipeApis(String page, String query, String category, isSearching) async {
    if (!isSearching) {
      _subCategoryLoading = true;
    }
    _apiLoading = true;
    await getRecipeApi(page, query, category, isSearching);
    _apiLoading = false;
    _subCategoryLoading = false;
    notifyListeners();
  }

  Future getRecipeApi(String currentPage, String query, String category,
      bool isSearching) async {
    recipeList.clear();
    String url =
        "https://dashencon.com/recipes/api/ds_her/v1/recipes?page=$currentPage&per_page=15&category=$category&query=$query";

    // The old api endpoint:- https://dashencon.com/recipes/api/ds_her/v1/recipes?page=1&per_page=15&category=$query

    Dio dio = Dio();
    final response = await dio.get(url);
    Recipe recipe;
    response.data["recipes"].forEach((el) async => {
          recipe = Recipe.fromJson(el), /* TODO: recipeList.add(recipe)*/
        });
  }

  Future fetchRecipesByCategory(String category) async {
    _loading = true;
    recipes.clear();
    // recipeList.clear();
    String url =
        "https://dashencon.com/recipes/api/ds_her/v1/recipes?page=1&per_page=15&category=$category";

    // The old api endpoint:- https://datascienceplc.com/api/ds_her/v1/recipe/popular?page=1&per_page=15&category=Breakfast

    Dio dio = Dio();
    final response = await dio.get(url);

    Recipe recipe;
    response.data["recipes"].forEach((el) async => {
          recipe = Recipe.fromJson(el),
          recipes.add(recipe),
        });

    if (recipeList.isEmpty) {
      Recipe recip;
      response.data["random"].forEach(
          (el) async => {recip = Recipe.fromJson(el), recipeList.add(recip)});
    }

    _loading = false;
    notifyListeners();
  }

  Future fetchRecipesBySearch(String query) async {
    _loading = true;
    searchedRecipes.clear();
    UpdateShouldNotify;

    String url =
        "https://dashencon.com/recipes/api/ds_her/v1/recipes/search?page=1&per_page=15&query=$query";

    Dio dio = Dio();
    final response = await dio.get(url);

    Recipe recipe;
    response.data["recipe"].forEach((el) async => {
          recipe = Recipe.fromJson(el),
          searchedRecipes.add(recipe),
        });

    totalQuery = response.data["total"];

    _loading = false;
    notifyListeners();
  }

  Future fetchRecipe() async {
    favoriteRecipes.clear();
    Dio dio = Dio();
    _favLoading = true;

    try {
      final db = await SqlHelper.db();

      final recipeSlugs = await db.rawQuery('SELECT * FROM favorite');

      for (final slugMap in recipeSlugs) {
        final slug = slugMap['recipe_slug'] as String;
        favList.add(slug);
        String url = "https://dashencon.com/recipes/api/ds_her/v1/recipe/$slug";
        final response = await dio.get(url);

        Recipe recipe = Recipe.fromJson(response.data["recipe"]);
        favoriteRecipes.add(recipe);
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching data: $e');
    }
    _favLoading = false;
    notifyListeners();
  }

  Future<void> refreshFavoriteRecipes() async {
    _favLoading = true;
    favList.clear();

    try {
      final db = await SqlHelper.db();

      final recipeSlugs = await db.rawQuery('SELECT * FROM favorite');

      for (final slugMap in recipeSlugs) {
        final slug = slugMap['recipe_slug'] as String;
        favList.add(slug);
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching data: $e');
    }
    _favLoading = false;
    notifyListeners();
  }
}