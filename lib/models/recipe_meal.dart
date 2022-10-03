import 'package:flutter/cupertino.dart';
import '../models/image_model.dart';
import '../models/ingredient_model.dart';
import '../models/nutrition_model.dart';
import '../models/steps_model.dart';

class RecipeMeal with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final String rating;
  final String numOfRatings;
  final String category;
  final List<ImageModel> images;
  final List<Ingredient> ingredients;
  final List<Nutrition> nutritions;
  final List<Step> steps;

  // final String strInstruction;

  RecipeMeal(
      this.id,
      this.name,
      this.description,
      this.rating,
      this.numOfRatings,
      this.category,
      this.images,
      this.ingredients,
      this.nutritions,
      this.steps);

  RecipeMeal.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['recipeName'] as String,
        description = json['recipeDescription'] as String,
        rating = json['recipeRating'] as String,
        numOfRatings = json['numOfRatings'] as String,
        category = json['recipeMainCategory'] as String,
        images = (json['images'] as List<dynamic>).map((image) => ImageModel.fromJson(image as Map<String, dynamic>)).toList(),
        ingredients = (json['ingredients'] as List<dynamic>).map((ingredient) => Ingredient.fromJson(ingredient as Map<String, dynamic>)).toList(),
        nutritions = (json['nutritions'] as List<dynamic>).map((nutrition) => Nutrition.fromJson(nutrition as Map<String, dynamic>)).toList(),
        steps = (json['directions'] as List<dynamic>).map((step) => Step.fromJson(step as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'recipeName': name,
        'recipeDescription': description,
        'recipeRating': rating,
        'numOfRatings': numOfRatings,
        'recipeMainCategory': category,
        'images': images,
        'ingredients': ingredients,
        'nutritions': nutritions,
        'directions': steps,
        
        // 'strInstruction': strInstruction
      };
}
