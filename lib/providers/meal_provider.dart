import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../models/recipe_meal.dart';
import '../models/meal_model.dart';
import 'package:http/http.dart' as http;

class Meals with ChangeNotifier {

  bool _loading = false;
  List<Meal> meals = [];

  // Future<Meal> getRandomMeals() async {
  //   final _baseUrl = "https://www.themealdb.com";
  //   Dio dio = Dio();
  //   final response = await dio.get("$_baseUrl/api/json/v1/1/random.php");
  //   if (response.statusCode == 200) {
  //     return Meal.fromJson(response.data);
  //   } else {
  //     throw Exception("Failed to get random meals");
  //   }
  // }

  bool get  loading => _loading;

  fetchedMeals() async {
  _loading = true;
  meals = await fetchMeals();
  _loading = false;
  print('me');
  print(meals);
  notifyListeners();
} 

  searchFetchedMeals(String query) async {
  _loading = true;
  meals = await searchMeals(query);
  _loading = false;

  notifyListeners();
} 



}

// Future<List<Meal>> fetchMeals() async {
//   List<Meal> recipeList = [];
//   String url = "https://www.themealdb.com/api/json/v1/1/search.php?f=a";

//   final response = await http.get(Uri.parse(url));

//   var result = jsonDecode(response.body);
//   var fetchedMeals = result["meals"];
//   List<dynamic> fec = fetchedMeals;

//   // print(fetchedMeals);

//   fec.forEach((meal) {
//     Meal m = new Meal(meal["idMeal"], meal["strMeal"], meal["strCategory"],
//         meal["strMealThumb"], meal["strInstruction"]);

//     recipeList.add(m);
//   });

//   print(recipeList);

//   return recipeList;
// }

Future<List<Meal>> fetchMeals() async {
  List<Meal> recipeList = [];
  String url = "https://www.themealdb.com/api/json/v1/1/search.php?f=a";

  final response = await http.get(Uri.parse(url));

  var result = jsonDecode(response.body);
  var fetchedMeals = result["meals"];

  List<dynamic> fec = fetchedMeals;
  fec.forEach((meal) {
    Meal m = new Meal(meal["idMeal"], meal["strMeal"], meal["strCategory"],
        meal["strMealThumb"]);

    recipeList.add(m);
  });

  return recipeList;

}



Future<List<Meal>> fetchMealsByCategory(String category) async {
  List<Meal> recipeList = [];
  String url = "https://www.themealdb.com/api/json/v1/1/search.php?f=c";

  final response = await http.get(Uri.parse(url));

  var result = jsonDecode(response.body);
  var fetchedMeals = result["meals"];

  List<dynamic> fec = fetchedMeals;
  fec.forEach((meal) {
    Meal m = new Meal(meal["idMeal"], meal["strMeal"], meal["strCategory"],
        meal["strMealThumb"]);

    recipeList.add(m);
  });

// List<Meal> filteredCategory = recipeList.where((element) => element.strCategory.toLowerCase().contains(category)).toList();

  return recipeList;
}

Future<List<Meal>> searchMeals(String query) async {
  List<Meal> recipeList = [];
  String url = "https://www.themealdb.com/api/json/v1/1/search.php?f=$query";

  final response = await http.get(Uri.parse(url));

  var result = jsonDecode(response.body);
  var fetchedMeals = result["meals"];

  List<dynamic> fec = fetchedMeals;
  fec.forEach((meal) {
    Meal m = new Meal(meal["idMeal"], meal["strMeal"], meal["strCategory"],
        meal["strMealThumb"]);

    recipeList.add(m);
  });

  return recipeList;


}




Future<List<RecipeMeal>> getTestJson() async{

String url = "https://datascienceplc.com/api/ds_her/v1/recipe/popular?page=1&category=bread&per_page=15&category=bread";

final res = await http.get(Uri.parse(url));

  var result = jsonDecode(res.body);

  var fetchedRecipes = result["recipes"];
  var fetchedRecipes2 = result["recipes"][1];

  List<RecipeMeal> recipes = [];



  final _baseUrl = "https://www.themealdb.com";
    Dio dio = Dio();
    print("before the request");
    final response = await dio.get("https://datascienceplc.com/api/ds_her/v1/recipe/popular?page=1&per_page=15&category=bread");
    print("before the request");
      print(response.data["recipes"].length);
    if (response.statusCode == 200) {
      print("Status code is okay");
      // var x = RecipeMeal.fromJson(response.data);

RecipeMeal recipe;

// Future<List<RecipeMeal>> addRecipes() {

      response.data["recipes"].forEach((el) async => {
        recipe =  RecipeMeal.fromJson(el),
        recipes.add(recipe),
      });

// }
    } else {
      throw Exception("Failed to get random meals");
    }

print(recipes[0].ingredients[0].name);
  

  // print('Testing json...................');
  // print(fetchedRecipes);
  // print('Testing json2...................');
  // print(fetchedRecipes2);


return recipes;
}