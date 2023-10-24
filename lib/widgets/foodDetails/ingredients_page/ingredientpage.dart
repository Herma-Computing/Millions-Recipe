import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../models/ingredition.dart';
import '../../../models/recipe_model.dart';

class Ingredients extends StatefulWidget {
  final Recipe ingredient;
  const Ingredients({super.key, required this.ingredient});

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  List imagesList = [];
  // switchMethod(String name) {
  //   for (var i in widget.ingredient.ingredients) {
  //     if (i.name.toLowerCase().contains("carrort")) {
  //       imagesList.add(ingImages['carrot']);
  //     }else if(i.name.toLowerCase().contains("apple")){
  //       imagesList.add(ingImages['apple']);
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();

    for (var ingredient in widget.ingredient.ingredients) {
      List temp = [];
      String theImage = "";
      for (var key in ingImages.keys) {
        // print(key);
        // print("${ingredient.name.toLowerCase().contains(key)} ${key}");
        if (ingredient.name.toLowerCase().contains(key)) {
          // temp.add(ingImages[key]);
          theImage = ingImages[key]!;
          // imagesList.add(ingImages[key]);
          break;
        } else {
          // temp.add("assets/Food-2.png");
          // imagesList.add("assets/Food-2.png");
          theImage = "assets/Food-2.png";
        }
      }
      imagesList.add(theImage);
    }

    print(imagesList);
  }

  String image = "";

  var ingImages = {
    'carrot': "assets/testAssets/carrot.png",
    'apple': "assets/testAssets/apple.png",
    'egg': "assets/testAssets/eggs.png",
    'frute': "assets/testAssets/frute.png",
    'milk': "assets/testAssets/milk.png",
    'tomato': "assets/testAssets/tomato-basic-knives-and-their-uses-1 1.png",
    'cheese': "assets/testAssets/yellow_cheese.png",
    'banana': "assets/testAssets/banana.png",
    'avocado': "assets/testAssets/Avocado 05.jpg",
    'flour': "assets/testAssets/Flour 03.jpg",
    'potato': "assets/testAssets/Flour 03.jpg",
    'lemon': "assets/testAssets/lemon.jpg",
    'onion': "assets/testAssets/Onion.jpg",
    'pepper': "assets/testAssets/Red_Pepper.jpg",
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: widget.ingredient.ingredients.length,
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
                                //   Image.asset(switchMethod(widget
                                //       .ingredient.ingredients[index].name
                                //       .toLowerCase())),
                                // )

                                // NetworkImage(ingredientsItems[index].image))
                                AssetImage(imagesList[index]))),
                  ),
                  title: Text(
                    widget.ingredient.ingredients[index].name,
                  ),
                  subtitle: Text(
                    "${widget.ingredient.ingredients[index].quantity}"
                    " ${widget.ingredient.ingredients[index].unit}",
                  ),
                  trailing: Text(
                    ingredientsItems[0].place,
                    style: TextStyle(
                        color: ingredientsItems[0].status == 1
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
