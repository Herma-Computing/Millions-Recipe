import 'package:flutter/cupertino.dart';
import 'package:millions_recipe/models/sub_category.dart';
import '../models/recipe_model.dart';
import 'package:dio/dio.dart';
import '../api_service/constants.dart';

class Recipes with ChangeNotifier {
  bool _loading = false;
  List<Recipe> recipes = [];

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
        "${AppUrl.baseDSPLCUrl}/search?page=$currentPage&per_page=15&category=$category&query=$query";

    Dio dio = Dio();
    final response = await dio.get(url);
    Recipe recipe;
    response.data["recipes"].forEach(
        (el) async => {recipe = Recipe.fromJson(el), recipeList.add(recipe)});
  }

  Future fetchRecipesByCategory(String category) async {
    _loading = true;
    recipes.clear();
    String url =
        "${AppUrl.baseDSPLCUrl}/popular?page=1&per_page=15&category=$category";

    Dio dio = Dio();
    final response = await dio.get(url);

    // var result = jsonDecode(response.data);

    Recipe recipe;
    response.data["recipes"].forEach((el) async => {
          recipe = Recipe.fromJson(el),
          recipes.add(recipe),
        });
    subCategories.clear();
    SubCategory subCategory;
    response.data["sub_categories"].forEach((el) async => {
          subCategory = SubCategory.fromJson(el),
          subCategories.add(subCategory)
        });

    _loading = false;
    notifyListeners();
  }

  Future fetchRecipesBySearch(String query) async {
    _loading = true;
    recipes.clear();
    String url =
        "${AppUrl.baseDSPLCUrl}/popular?page=1&per_page=15&category=$query";

    Dio dio = Dio();
    final response = await dio.get(url);

    // var result = jsonDecode(response.data);

    Recipe recipe;
    response.data["recipes"].forEach((el) async => {
          recipe = Recipe.fromJson(el),
          recipes.add(recipe),
        });

    _loading = false;
    notifyListeners();
  }
}
