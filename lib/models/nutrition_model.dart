import 'package:flutter/cupertino.dart';

class Nutrition with ChangeNotifier {
  final String name;
  final String value;
  // ignore: non_constant_identifier_names
  final String daily_value;

  // final String strInstruction;

  Nutrition(this.name, this.value, this.daily_value);

  Nutrition.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        value = json['value'] as String,
        daily_value = json['daily_value'] == null
            ? "0"
            : json['daily_value'].replaceAll(RegExp('[^0-9]'), '') as String;

  Map<String, dynamic> toJson() =>
      {'name': name, 'value': value, 'daily_value': daily_value};
}
