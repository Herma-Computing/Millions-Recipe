import 'package:flutter/cupertino.dart';

class SubCategory with ChangeNotifier {
  final String name;


  // final String strInstruction;

  SubCategory(this.name);

  SubCategory.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String
        ;

  Map<String, dynamic> toJson() => {
        'name': name,
        
      };
}
