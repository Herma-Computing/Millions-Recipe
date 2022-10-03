import 'package:flutter/cupertino.dart';

class ImageModel with ChangeNotifier {
  final String url;


  ImageModel(this.url);

  ImageModel.fromJson(Map<String, dynamic> json)
      : url = json['img_url'] as String;

  Map<String, dynamic> toJson() => {
        'img_url': url,
      };
}
