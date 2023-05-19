import 'package:flutter/material.dart';
import '../../../models/recipe_model.dart';

class Nutrition extends StatelessWidget {
  final Recipe meal;
  const Nutrition({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: meal.nutritions.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: Text(meal.nutritions[index].name),
                trailing: Text(
                    "${meal.nutritions[index].value}${meal.nutritions[index].unit}"),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 1,
                color: const Color.fromARGB(48, 85, 84, 84),
              )
            ],
          );
        });
  }
}
