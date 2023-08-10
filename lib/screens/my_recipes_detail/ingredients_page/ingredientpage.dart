// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../models/ingredition.dart';

// ignore: must_be_immutable
class MyIngredient extends StatelessWidget {
  var ingredient;
  MyIngredient({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    final ingredientListJson = ingredient['ingredient'] as String;
    final List<dynamic> ingredientList = jsonDecode(ingredientListJson);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: ingredientList.length,
              itemBuilder: (context, index) {
                final ingredientItem = ingredientList[index];
                return ListTile(
                  leading: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      boxShadow: [kBoxShadow],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  title: Text(
                    ingredientItem['name'],
                  ),
                  subtitle: Text(
                    " ${ingredientItem['quantity']}",
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
