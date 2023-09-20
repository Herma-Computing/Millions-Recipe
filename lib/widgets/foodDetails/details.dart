import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../database/database_helper.dart';
import '../../providers/recipe_provider.dart';
import '../../screens/cooking_steps_screen.dart';
import 'Description/description.dart';
import 'comment_widget.dart';
import 'nutration/nutration.dart';
import '../../models/recipe_model.dart';
import 'Diet/diet.dart';
import 'ingredients_page/ingredientpage.dart';

class FoodDetails extends StatefulWidget {
  final Recipe meal;
  const FoodDetails({Key? key, required this.meal}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  final PageController _pageController = PageController(initialPage: 0);
  int pageviewSelected = 0;
  int currentImageIndex = 0;

  bool isFavorited = false;

  @override
  void initState() {
    checkFavoriteStatus();
    fetchRecipes();
    super.initState();
  }

  Future<void> fetchRecipes() async {
    final recipeProvider = Provider.of<Recipes>(context, listen: false);
    await recipeProvider.refreshFavoriteRecipes();
    // await recipeProvider.refreshFavoriteRecipes();
  }

  Future<void> checkFavoriteStatus() async {
    final isFavorite = await SqlHelper.isRecipeFavorite(widget.meal.slug);
    setState(() {
      isFavorited = isFavorite;
    });
  }

  Future<void> toggleFavoriteStatus() async {
    if (isFavorited) {
      await SqlHelper.deleteFavorite(widget.meal.slug);
    } else {
      await SqlHelper.insertFavorite(widget.meal.slug);
    }
    setState(() {
      isFavorited = !isFavorited;
    });
    fetchRecipes();
  }

  List<Widget> pages = [];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      Ingredients(ingredient: widget.meal),
      Nutrition(meal: widget.meal),
      Diet(meal: widget.meal),
    ];
    Color black = const Color.fromARGB(115, 46, 46, 46);
    Color green = Colors.green;
    Color white = const Color(0xFFFFFFFF);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: PageView.builder(
                      itemCount: widget.meal.images.length,
                      onPageChanged: (int index) {
                        setState(() {
                          currentImageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          widget.meal.images[index].url,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 15,
                    right: 15,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        iconButton(
                          white,
                          black,
                          Icons.arrow_back,
                          () => Navigator.pop(context),
                        ),
                        Row(
                          children: [
                            iconButton(
                              white,
                              Colors.black,
                              Icons.comment_outlined,
                              () => showModalBottomSheet(
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(55.0),
                                  ),
                                ),
                                builder: (context) {
                                  return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.75,
                                      child: CommentWidget(
                                        recipeId: widget.meal.slug,
                                      ));
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            iconButton(
                              white,
                              isFavorited ? Colors.red : Colors.black,
                              isFavorited
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              toggleFavoriteStatus,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      '${currentImageIndex + 1}/${widget.meal.images.length}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 21),
                      child: Text(
                        widget.meal.name,
                        style: GoogleFonts.poppins(
                          fontSize: 21,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: methdOfmenu(
                                  false,
                                  black,
                                  Icons.group_outlined,
                                  () => {},
                                  "${widget.meal.serving} people"),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: methdOfmenu(
                                    false,
                                    black,
                                    Icons.access_time_outlined,
                                    () => {},
                                    widget.meal.total_time)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: methdOfmenu(
                                    false,
                                    black,
                                    Icons.egg_outlined,
                                    () => {},
                                    "${widget.meal.nutritions[1].value}kcal"),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: methdOfmenu(true, green, Icons.check_box,
                                    () => {}, "You have all the ingredients"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Descriptions(meal: widget.meal),
              const SizedBox(
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  children: [
                    Expanded(
                      child:
                          pageViewTextButton(0, "Ingredients", true, green, () {
                        _pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }),
                    ),
                    Expanded(
                      child:
                          pageViewTextButton(1, "Nutrition", false, green, () {
                        _pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }),
                    ),
                    Expanded(
                      child:
                          pageViewTextButton(2, "Categories", false, green, () {
                        _pageController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 450,
                child: Expanded(
                  child: PageView(
                    onPageChanged: (int index) {
                      setState(() {
                        pageviewSelected = index;
                      });
                    },
                    controller: _pageController,
                    children: pages,
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => CookingSteps(
                          meal: widget.meal,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 250,
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Show cooking steps",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToPage(int index) {
    if (index >= 0 && index < pages.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Container iconButton(
      Color white, Color black, IconData icon, GestureTapCallback x) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(shape: BoxShape.circle, color: white),
      child: Center(
        child: IconButton(
          onPressed: x,
          icon: Icon(icon, color: black),
        ),
      ),
    );
  }

  Row methdOfmenu(bool isSelected, Color color, IconData icon,
      GestureTapCallback x, String title) {
    return Row(
      children: [
        GestureDetector(
          onTap: x,
          child: Icon(icon,
              color: isSelected == true
                  ? color
                  : Theme.of(context).colorScheme.secondary),
        ),
        Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
      ],
    );
  }

  GestureDetector pageViewTextButton(int index, String title, bool isSelected,
      Color green, GestureTapCallback function) {
    return GestureDetector(
      onTap: function,
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: pageviewSelected == index
                  ? green
                  : Theme.of(context).colorScheme.secondary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: 100,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: pageviewSelected == index ? green : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
