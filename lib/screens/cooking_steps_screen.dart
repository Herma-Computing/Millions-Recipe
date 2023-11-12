import 'package:flutter/material.dart';
import '../common/constants.dart';
import '../models/recipe_model.dart';

class CookingSteps extends StatelessWidget {
  final Recipe meal;
  const CookingSteps({super.key, required this.meal});
  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: kPrimaryColor.withOpacity(0.25),
              ),
              child: Icon(
                Icons.arrow_back,
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
        title: const Text(
          'Cooking Steps',
          style: TextStyle(
            // color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: ListView.builder(
            itemCount: meal.steps.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ((index + 1) % 2 == 0)
                              ? toogleStep(
                                  MediaQuery.sizeOf(context).width - 108,
                                  meal.steps[index].step,
                                  index)
                              : toogleIndex(index),
                          const SizedBox(
                            width: 18,
                          ),
                          ((index + 1) % 2 == 0)
                              ? toogleIndex(index)
                              : toogleStep(
                                  MediaQuery.sizeOf(context).width - 108,
                                  meal.steps[index].step,
                                  index),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  index > meal.steps[index].img_url.length
                      ? const SizedBox()
                      : meal.steps[index].img_url == "NO PIC"
                          ? const SizedBox()
                          : Row(
                              children: [
                                Container(
                                  color: kPrimaryColor,
                                  width: (cWidth / 0.8) - 48,
                                  height: 180,
                                  child: Image.network(
                                    // "https://cdn.dribbble.com/users/1013019/screenshots/3281397/media/9de100ad01c34ec34d35e843d33504f9.jpg?compress=1&resize=400x300",
                                    meal.steps[index].img_url,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ],
                            ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  SizedBox toogleStep(double cWidth, String steps, int index) {
    return SizedBox(
      width: cWidth,
      // /cWidth - 16,
      child: Column(
        children: <Widget>[
          Text(
            steps,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }

  Container toogleIndex(int index) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: kPrimaryColor,
      ),
      child: Text(
        "${index + 1}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
