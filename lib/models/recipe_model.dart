// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import '../models/image_model.dart';
import '../models/ingredient_model.dart';
import '../models/nutrition_model.dart';
import '../models/steps_model.dart';
import 'categories_model.dart';

class Recipe with ChangeNotifier {
  //final String id;
  final String name;
  final String description;
  final String? rating;
  final String numOfRatings;
  final String total_time;
  final String prep_time;
  final String cook_time;
  final String additional_time;
  final String refrigerate_time;
  final List<CategoriesModel> category;
  final List<ImageModel> images;
  final List<Ingredient> ingredients;
  final List<Nutrition> nutritions;
  final List<Step> steps;

  Recipe(
      //this.id,
      this.name,
      this.description,
      this.rating,
      this.numOfRatings,
      this.total_time,
      this.prep_time,
      this.cook_time,
      this.additional_time,
      this.refrigerate_time,
      this.category,
      this.images,
      this.ingredients,
      this.nutritions,
      this.steps);

  Recipe.fromJson(Map<String, dynamic> json)
      : //id = json['id'] as String,
        name = json['name'] as String,
        description = json['description'] as String,
        rating = json['rating_points'] == null
            ? "0"
            : json['rating_points'] as String,
        numOfRatings =
            json['rating_count'] == null ? "0" : json['rating_count'] as String,
        total_time = json['total_time'] == null
            ? "0"
            : json['total_time'].replaceAll(RegExp('[^0-9]'), '') as String,
        prep_time = json['prep_time'] == null
            ? "0"
            : json['prep_time'].replaceAll(RegExp('[^0-9]'), '') as String,
        cook_time = json['cook_time'] == null
            ? "0"
            : json['cook_time'].replaceAll(RegExp('[^0-9]'), '') as String,
        additional_time = json['additional_time'] == null
            ? "0"
            : json['additional_time'].replaceAll(RegExp('[^0-9]'), '')
                as String,
        refrigerate_time = json['refrigerate_time'] == null
            ? "0"
            : json['refrigerate_time'].replaceAll(RegExp('[^0-9]'), '')
                as String,
        category = (json['categories'] as List<dynamic>)
            .map((categories) =>
                CategoriesModel.fromJson(categories as Map<String, dynamic>))
            .toList(),
        images = (json['images'] as List<dynamic>)
            .map((image) => ImageModel.fromJson(image as Map<String, dynamic>))
            .toList(),
        ingredients = (json['ingredients'] as List<dynamic>)
            .map((ingredient) =>
                Ingredient.fromJson(ingredient as Map<String, dynamic>))
            .toList(),
        nutritions = (json['nutritions'] as List<dynamic>)
            .map((nutrition) =>
                Nutrition.fromJson(nutrition as Map<String, dynamic>))
            .toList(),
        steps = (json['steps'] as List<dynamic>)
            .map((step) => Step.fromJson(step as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'name': name,
        'description': description,
        'rating_points': rating,
        'rating_count': numOfRatings,
        'totlatime': total_time,
        'prep_time': prep_time,
        'cook_time': cook_time,
        'additional_time': additional_time,
        'refrigerate_time': refrigerate_time,
        'categories': category,
        'images': images,
        'ingredients': ingredients,
        'nutritions': nutritions,
        'steps': steps,
      };
}
