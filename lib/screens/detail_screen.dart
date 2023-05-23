import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/recipe_model.dart';
import '../common/constants.dart';
// import '../models/meal_model.dart';
import '../common/shared.dart';
// import '../data.dart';

class DetailScreen extends StatelessWidget {
  final Recipe meal;
  final Key? key;

  const DetailScreen({required this.meal, this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: const [
          // Padding(
          //   padding: EdgeInsets.only(right: 16),
          //   child: Icon(
          //     Icons.favorite_border,
          //     color: Colors.black,
          //   ),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation1(meal.name),
                  buildTextSubTitleVariation1(meal.description),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 310,
              padding: const EdgeInsets.only(left: 16),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: meal.nutritions
                          .map((nutrition) => (Column(
                                children: [
                                  buildNutrition(
                                      nutrition.value,
                                      //TODO:- check daily_value with unit
                                      nutrition.name,
                                      nutrition.daily_value),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              )))
                          .toList(),
                    ),
                  ),
                  Positioned(
                    right: -80,
                    child: Hero(
                      tag: meal.images[0].url,
                      // child: PageView(
                      //   controller: controller,
                      //   children: meal.images.map((image) => (Container(
                      //     height: 110,
                      //     width: 110,
                      //     child: Text("meal"),
                      //   ))).toList(),
                      // )
                      child: Container(
                          height: 310,
                          width: 310,
                          // child: Image.network(meal.images[0].url),

                          child:
                              // Text("jss")
                              PageView(
                            controller: controller,
                            children: meal.images
                                .map((image) => (Container(
                                      height: 310,
                                      width: 310,
                                      child: Stack(
                                        children: [
                                          Image.network(image.url),
                                          Positioned(
                                              top: 140,
                                              left: 0,
                                              child: IconButton(
                                                  onPressed: () => {
                                                        controller.previousPage(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        300),
                                                            curve: Curves.ease)
                                                      },
                                                  icon: const Icon(
                                                    Icons.arrow_back_ios,
                                                    size: 35,
                                                  ))),
                                          Positioned(
                                              top: 140,
                                              right: 70,
                                              child: IconButton(
                                                  onPressed: () => {
                                                        controller.nextPage(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        300),
                                                            curve: Curves.ease)
                                                      },
                                                  icon: const Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 35,
                                                  )))
                                        ],
                                      ),
                                    )))
                                .toList(),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     height: 600,
            //     width: MediaQuery.of(context).size.width,
            //     child: Stack(
            //       children: [
            //         PageView(
            //           controller: controller,
            //           children: meal.images
            //               .map((image) => Container(
            //                   // width: 500,
            //                   height: 600,
            //                   child: Image.network(
            //                     image.url,
            //                     fit: BoxFit.contain,
            //                   )))
            //               .toList(),
            //         ),
            //         Positioned(
            //             top: 300,
            //             left: 0,
            //             child: IconButton(
            //                 onPressed: () => {
            //                       controller.previousPage(
            //                           duration: Duration(milliseconds: 300),
            //                           curve: Curves.ease)
            //                     },
            //                 icon: Icon(
            //                   Icons.arrow_back_ios,
            //                   size: 35,
            //                 ))),
            //         Positioned(
            //             top: 300,
            //             right: 0,
            //             child: IconButton(
            //                 onPressed: () => {
            //                       controller.nextPage(
            //                           duration: Duration(milliseconds: 300),
            //                           curve: Curves.ease)
            //                     },
            //                 icon: Icon(
            //                   Icons.arrow_forward_ios,
            //                   size: 35,
            //                 )))
            //       ],
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation2('Ingredients', false),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: meal.ingredients
                          .map((ingredient) => Column(
                                children: [
                                  buildTextSubTitleVariation1(
                                      ingredient.quantity +
                                          " " +
                                          ingredient.name),
                                ],
                              ))
                          .toList()

                      //  [

                      //   buildTextTitleVariation2('Ingredients', false),

                      //   buildTextSubTitleVariation1("2 cups pecans, divided"),
                      //   buildTextSubTitleVariation1("1 tablespoon unsalted butter, melted"),
                      //   buildTextSubTitleVariation1("1/4 teaspoon kosher salt, plus more"),
                      //   buildTextSubTitleVariation1("3 tablespoons fresh lemon juice"),
                      //   buildTextSubTitleVariation1("2 tablespoons olive oil"),
                      //   buildTextSubTitleVariation1("1/2 teaspoon honey"),

                      //   SizedBox(height: 16,),

                      //   buildTextTitleVariation2('Recipe preparation', false),

                      //   buildTextSubTitleVariation1("STEP 1"),
                      //   buildTextSubTitleVariation1("In a medium bowl, mix all the marinade ingredients with some seasoning. Chop the chicken into bite-sized pieces and toss with the marinade. Cover and chill in the fridge for 1 hr or overnight."),

                      //   buildTextSubTitleVariation1("STEP 2"),
                      //   buildTextSubTitleVariation1("In a large, heavy saucepan, heat the oil. Add the onion, garlic, green chilli, ginger and some seasoning. Fry on a medium heat for 10 mins or until soft."),

                      //   buildTextSubTitleVariation1("STEP 3"),
                      //   buildTextSubTitleVariation1("Add the spices with the tomato purée, cook for a further 2 mins until fragrant, then add the stock and marinated chicken. Cook for 15 mins, then add any remaining marinade left in the bowl. Simmer for 5 mins, then sprinkle with the toasted almonds. Serve with rice, naan bread, chutney, coriander and lime wedges, if you like."),

                      // ],
                      ),
                  const SizedBox(
                    height: 16,
                  ),
                  buildTextTitleVariation2('Recipe preparation', false),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: meal.steps.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          buildTextSubTitleVariation1("STEP ${index + 1}"),
                          buildTextSubTitleVariation1(meal.steps[index].step),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {},
      //     backgroundColor: kPrimaryColor,
      //     icon: Icon(
      //       Icons.play_circle_fill,
      //       color: Colors.white,
      //       size: 32,
      //     ),
      //     label: Text(
      //       "Watch Video",
      //       style: const TextStyle(
      //         color: Colors.white,
      //         fontSize: 16,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     )),
    );
  }

  Widget buildNutrition(String value, String title, String subTitle) {
    return Container(
      height: 60,
      width: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.all(
          const Radius.circular(50),
        ),
        boxShadow: [kBoxShadow],
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [kBoxShadow],
            ),
            child: Center(
              child: Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
