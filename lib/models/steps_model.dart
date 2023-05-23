import 'package:flutter/cupertino.dart';

class Step with ChangeNotifier {
  final String step;
  // ignore: non_constant_identifier_names
  final String img_url;

  Step(this.step, this.img_url);

  Step.fromJson(Map<String, dynamic> json)
      : step = json['step'] as String,
        img_url =
            json['img_url'] != null ? json['img_url'] as String : "NO PIC";

  Map<String, dynamic> toJson() => {
        'step': step,
        'img_url': img_url,
      };
}
