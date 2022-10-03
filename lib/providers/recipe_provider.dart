

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../models/recipe_model.dart';
import 'package:dio/dio.dart';


class Recipes with ChangeNotifier {

  bool _loading = false;
  List<Recipe> recipes = [];

  bool get loading => _loading;



Future fetchRecipes() async {


  _loading = true;
  recipes.clear();
  String url = "https://datascienceplc.com/api/ds_her/v1/recipe/popular?page=1&per_page=15&category=bread";


  Dio dio = Dio();
  final response = await dio.get(url);
  print(response);

  // var result = jsonDecode(response.data);

  Recipe recipe;
  response.data["recipes"].forEach((el) async => {
    recipe = Recipe.fromJson(el),
    recipes.add(recipe),

  });


  print("list of recipes recieved");
  print(recipes.length);


  _loading = false;
  notifyListeners();
}

Future fetchRecipesByCategory(String category) async {

  _loading = true;
  recipes.clear();
  String url = "https://datascienceplc.com/api/ds_her/v1/recipe/popular?page=1&category=bread&per_page=15&category=$category";

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

Future fetchRecipesBySearch(String query) async {

  _loading = true;
  recipes.clear();
  String url = "https://datascienceplc.com/api/ds_her/v1/recipe/popular?page=1&category=bread&per_page=15&category=$query";

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

Future searchRecipes(String query) async{
   
String queryData = query == "" ? "a" : query;

  _loading = true;
  recipes.clear();
  String url = "https://datascienceplc.com/api/ds_her/v1/recipe/popular?page=1&category=bread&per_page=15&category=$queryData";
  Dio dio = Dio();
  final response = await dio.get(url);

  Recipe recipe;
  response.data["ecipes"].forEach((el) async => {
    recipe = Recipe.fromJson(el),
    recipes.add(recipe)
  });
  _loading = false;
  notifyListeners();

  
}


 
}