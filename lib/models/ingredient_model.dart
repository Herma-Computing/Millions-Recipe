import 'package:flutter/cupertino.dart';

class Ingredient with ChangeNotifier {
  final String amount;
  final String name;


  // final String strInstruction;

  Ingredient(this.amount, this.name);

  Ingredient.fromJson(Map<String, dynamic> json)
      : amount = json['ing_amount'] as String,
        name = json['ing_name'] as String
        ;

  Map<String, dynamic> toJson() => {
        'ing_amount': amount,
        'ing_name': name,
        
      };
}


