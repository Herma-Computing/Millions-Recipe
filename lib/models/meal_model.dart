import 'package:flutter/cupertino.dart';

class Meal with ChangeNotifier {
  final String idMeal;
  final String strMeal;
  final String strCategory;
  final String strMealThumb;
  // final String strInstruction;

  Meal(this.idMeal, this.strMeal, this.strCategory, this.strMealThumb,
     );

  Meal.fromJson(Map<String, dynamic> json)
      : idMeal = json['idMeal'],
        strMeal = json['strMeal'],
        strCategory = json['strCategory'],
        strMealThumb = json['strMealThumb'];
        // strInstruction = json['strInstruction'];

  Map<String, dynamic> toJson() => {
        'idMeal': idMeal,
        'strMeal': strMeal,
        'strCategory': strCategory,
        'strMealThumb': strMealThumb,
        // 'strInstruction': strInstruction
      };
}


