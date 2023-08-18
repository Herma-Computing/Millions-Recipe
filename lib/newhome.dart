import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:millions_recipe/screens/notifcations.dart';
import 'package:millions_recipe/screens/all_recipes.dart';
import 'package:millions_recipe/common/constants.dart';
import 'package:millions_recipe/providers/recipe_provider.dart';
import 'package:millions_recipe/widgets/foodDetails/details.dart';
import 'package:provider/provider.dart';
import 'api/shared_preference/shared_preference.dart';
import 'database/database_helper.dart';
import 'models/recipe_model.dart';
import 'widgets/search_widget.dart';

class NewHome extends StatefulWidget {
  const NewHome({Key? key}) : super(key: key);

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  List<Recipe> result = [];
  Future<List<Recipe>> results = Future.value([]);
  bool loading = true;
  int offset = 0;
  int currentPage = 1;
  bool fetchedRecipes = false;

  @override
  void initState() {
    super.initState();
    fetchPopular();
    fetchRecent();
    fetchSlug();
    update();
    userName = UserPreferences.getName() ?? "Guest";
  }

  Future<void> update() async {
    final recipeProvider = Provider.of<Recipes>(context, listen: false);
    recipeProvider.refreshFavoriteRecipes();
  }

  late String userName;

  List favList = [];

  Future<void> fetchSlug() async {
    final db = await SqlHelper.db();
    final recipeSlugs = await db.rawQuery('SELECT * FROM favorite');

    for (final slugMap in recipeSlugs) {
      final slug = slugMap['recipe_slug'] as String;
      favList.add(slug);
    }
  }

  void fetchPopular() {
    final recipeProvider = Provider.of<Recipes>(context, listen: false);

    if (!fetchedRecipes) {
      recipeProvider.fetchRecipesByCategory("");
    }
    setState(() {
      fetchedRecipes = true;
    });

    recipeProvider.fetchRecipesByCategory(_categoriesRequest[_selectedIndex]);
    setState(() {
      results = Future.value(recipeProvider.recipes);
    });
  }

  void fetchRecent() async {
    final recipeProvider = Provider.of<Recipes>(context, listen: false);
    await recipeProvider.getRecipeApis('1', '', '', false);
  }

  final List<String> _categoriesRequest = [
    '',
    'breakfast-and-brunch',
    'healthy',
    'appetizers-and-snacks',
    'salads',
    'side-dishes',
    'soups-and-stews',
    'bread',
    'drinks',
    'desserts',
  ];

  final List<String> _categories = [
    'Popular',
    'Breakfast and Brunch',
    'Healthy',
    'Appetizers and Snacks',
    'Salads',
    'Side Dishes',
    'Soups and Stews',
    'Bread',
    'Drinks',
    'Desserts',
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<Recipes>(context);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Hi, $userName',
                  style: const TextStyle(
                    color: Color(0xff303030),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Let\'s make a masterpiece',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0x80303030),
                  ),
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GestureDetector(
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Notifications(),
                    ),
                  )
                },
                child: SizedBox(
                  width: 24,
                  height: 22,
                  child: SvgPicture.asset(
                    'assets/allSVG/Notification-Icon.svg',
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 22,
            )
          ],
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          topSearchBar(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 16),
            child: const Text(
              'Popular Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _categories.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    fetchPopular();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      gradient: _selectedIndex == index
                          ? const LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Color(0xff15BE77),
                                Color(0xff53E88B),
                              ],
                            )
                          : const LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        _categories[index],
                        style: TextStyle(
                          color: _selectedIndex == index
                              ? Colors.white
                              : const Color(0xff53E88B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 265.0,
            child: Consumer<Recipes>(
              builder: (context, fs, child) {
                return Container(
                    child: recipeProvider.loading
                        ? Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 4,
                              color: kPrimaryColor,
                            ),
                          )
                        : recipeProvider.recipes.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: recipeProvider.recipes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // fetchSlug();
                                  bool isFavorited = recipeProvider.favList
                                      .contains(
                                          recipeProvider.recipes[index].slug);

                                  try {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 19.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          update();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FoodDetails(
                                                        meal: recipeProvider
                                                            .recipes[index])),
                                          );
                                        },
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 100.0 / 4.0),
                                              padding: const EdgeInsets.only(
                                                  top: 100.0 / 2.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color:
                                                      const Color(0xffF1F1F1),
                                                ),
                                                padding: const EdgeInsets.only(
                                                    top: 100.0 / 2.0),
                                                width: 150,
                                                height: 176.0,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        recipeProvider
                                                            .recipes[index]
                                                            .name,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
                                                        style: const TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          8.0),
                                                              child: Text(
                                                                'Time',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0x402E2E2E),
                                                                  fontSize:
                                                                      12.0,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 8.0,
                                                                bottom: 14,
                                                              ),
                                                              child: Text(
                                                                recipeProvider
                                                                    .recipes[
                                                                        index]
                                                                    .total_time,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xff2E2E2E),
                                                                  fontSize:
                                                                      12.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10.0,
                                                                      bottom:
                                                                          10.0),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              width: 30,
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: isFavorited
                                                                    ? const Color(
                                                                        0xffE23E3E)
                                                                    : Colors
                                                                        .white,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/allSVG/Favorite-Icon.svg',
                                                                colorFilter:
                                                                    ColorFilter
                                                                        .mode(
                                                                  !isFavorited
                                                                      ? const Color(
                                                                          0xff2E2E2E)
                                                                      : const Color(
                                                                          0xffffffff),
                                                                  BlendMode
                                                                      .srcIn,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10.0),
                                              width: 125.0,
                                              height: 125.0,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      kPrimaryColor,
                                                  radius: 50,
                                                  backgroundImage: NetworkImage(
                                                      recipeProvider
                                                          .recipes[index]
                                                          .images[0]
                                                          .url),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  } catch (err) {
                                    return Container();
                                  }
                                },
                              )
                            : const Center(
                                child: Text(
                                  'No Recipes Found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Random Recipes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllRecipes()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('See all',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff53E88B))),
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'assets/allSVG/Right-Arrow-Icon.svg',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 200.0,
            child: recipeProvider.apiLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  )
                : recipeProvider.recipeList.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: recipeProvider.recipeList.length ~/ 2,
                        itemBuilder: (BuildContext context, int index) {
                          try {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FoodDetails(
                                          meal:
                                              recipeProvider.recipeList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    height: 200,
                                    width: 150,
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            recipeProvider.recipeList[index]
                                                    .images.isNotEmpty
                                                ? recipeProvider
                                                    .recipeList[index]
                                                    .images[0]
                                                    .url
                                                : "https://cdn.dribbble.com/users/1013019/screenshots/3281397/media/9de100ad01c34ec34d35e843d33504f9.jpg?compress=1&resize=400x300",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          recipeProvider.recipeList[index].name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          } catch (err) {
                            return Container();
                          }
                        },
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
          ),
        ],
      ),
    );
  }
}