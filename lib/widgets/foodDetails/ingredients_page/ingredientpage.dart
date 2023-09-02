import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../models/ingredition.dart';
import '../../../models/recipe_model.dart';

class Ingredients extends StatelessWidget {
  var ingredient;
  Ingredients({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: ingredientsItems.length,
              // ingredientsItems.length,
              // Todo: ingredient.ingredients.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        boxShadow: [kBoxShadow],
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                NetworkImage(ingredientsItems[index].image))),
                  ),
                  title: Text(
                    ingredient.ingredients[index].name,
                  ),
                  subtitle: Text(
                    "${ingredient.ingredients[index].quantity}"
                    " ${ingredient.ingredients[index].unit}",
                  ),
                  trailing: Text(
                    ingredientsItems[index].place,
                    style: TextStyle(
                        color: ingredientsItems[index].status == 1
                            ? kPrimaryColor
                            : Colors.black),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
