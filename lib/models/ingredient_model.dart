import 'package:flutter/cupertino.dart';

class Ingredient with ChangeNotifier {
  final String quantity;
  final String name;
  final String unit;

  // final String strInstruction;

  Ingredient(this.quantity, this.name, this.unit);

  Ingredient.fromJson(Map<String, dynamic> json)
      : quantity = json['quantity'] as String,
        name = json['name'] as String,
        unit = json['unit'] as String;

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'name': name,
        'unit': unit,
      };
}
