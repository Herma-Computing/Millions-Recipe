import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../models/recipe_model.dart';
import '../providers/recipe_provider.dart';
import '../widgets/foodDetails/details.dart';

class AllRecipes extends StatefulWidget {
  const AllRecipes({super.key});

  @override
  State<AllRecipes> createState() => _AllRecipesState();
}

class _AllRecipesState extends State<AllRecipes> {
  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<Recipes>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: IconButton(
            alignment: Alignment.centerLeft,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
            )),
      ),
      body: recipeProvider.recipeList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView.builder(
                itemCount: recipeProvider.recipeList.length,
                itemBuilder: (context, index) {
                  return Expanded(
                    child: Column(
                      children: [
                        recipeCard(
                            recipeProvider.recipes[index].images.isNotEmpty
                                ? recipeProvider.recipeList[index].images[0].url
                                : "https://cdn.dribbble.com/users/1013019/screenshots/3281397/media/9de100ad01c34ec34d35e843d33504f9.jpg?compress=1&resize=400x300",
                            recipeProvider.recipeList[index].name,
                            recipeProvider.recipeList[index].total_time,
                            recipeProvider
                                .recipeList[index].nutritions[1].value,
                            recipeProvider.recipeList[index]),
                        const SizedBox(
                          height: 12,
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          : const Center(
              child: Text(
                'No Recipes Found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
    );
  }

  Widget recipeCard(
      String pic, String mealName, String time, String calories, Recipe meal) {
    return Stack(
      children: [
        Card(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 35, left: 13, bottom: 14, right: 7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 130,
                      width: 127,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Image.network(pic),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              mealName,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Row(children: const [
                              Icon(Icons.people_alt_outlined),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '2 people',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Row(children: [
                              const Icon(Icons.timer_outlined),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '$time min',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Row(children: [
                              const Icon(CupertinoIcons.flame),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '$calories Kcal',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Row(children: const [
                              Icon(
                                Icons.check_box_outlined,
                                color: Color(0xff53E88B),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text(
                                  'You have all the ingedients',
                                  style: TextStyle(
                                      color: Color(0xff53E88B), fontSize: 12),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoodDetails(meal: meal)),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: 208.47,
                    height: 44,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Color(0xff15BE77),
                            Color(0xff53E88B),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Show Detail",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 3,
          child: Container(
            margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
            padding: const EdgeInsets.all(5.0),
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xffE23E3E),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/allSVG/Favorite-Icon.svg',
              // ignore: deprecated_member_use
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
