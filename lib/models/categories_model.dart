import 'package:flutter/cupertino.dart';

class CategoriesModel with ChangeNotifier {
  final String url;

  CategoriesModel(this.url);

  CategoriesModel.fromJson(Map<String, dynamic> json)
      : url = json['name'] as String;

  Map<String, dynamic> toJson() => {
        'name': url,
      };
}
