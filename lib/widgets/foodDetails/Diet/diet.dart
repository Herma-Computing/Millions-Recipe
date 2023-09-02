import 'package:flutter/material.dart';

import '../../../models/recipe_model.dart';

class Diet extends StatelessWidget {
  var meal;
  Diet({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30),
        child: ListView.builder(
          itemCount: (meal.category.length / 3).ceil(),
          itemBuilder: (context, rowIndex) {
            final startIndex = rowIndex * 3;
            final endIndex = startIndex + 3;
            final rowElements = meal.category.sublist(
                startIndex,
                endIndex > meal.category.length
                    ? meal.category.length
                    : endIndex);

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                for (var element in rowElements)
                  Expanded(
                      child:
                          container(element.url) // Replace with your own widget
                      ),
              ],
            );
          },
        ));
  }

  Container container(String title) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
          border: Border.all(
            color: Colors.grey,
            width: 2.0,
          )),
      child: Center(
          child: Text(
        textAlign: TextAlign.center,
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      )),
    );
  }
}
