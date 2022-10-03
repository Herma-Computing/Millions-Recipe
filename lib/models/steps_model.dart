import 'package:flutter/cupertino.dart';

class Step with ChangeNotifier {
  final String step;


  // final String strInstruction;

  Step(this.step);

  Step.fromJson(Map<String, dynamic> json)
      : step = json['direction'] as String
        ;

  Map<String, dynamic> toJson() => {
        'direction': step,
        
      };
}


