import 'package:flutter/cupertino.dart';

class Nutrition with ChangeNotifier {
  final String name;
  final String value;
  final String unit;


  // final String strInstruction;

  Nutrition(this.name, this.value, this.unit);

  Nutrition.fromJson(Map<String, dynamic> json)
      : name = json['nutrient_name'] as String,
        value= json['nutrient_value'] as String,
        unit =json['amount_unit'] as String
        ;

  Map<String, dynamic> toJson() => {
        'nutrient_name': name,
        'nutrient_value': value,
        'amount_unit': unit
        
      };
}


