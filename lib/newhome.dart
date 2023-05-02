import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:millions_recipe/providers/recipe_provider.dart';
import 'package:millions_recipe/screens/Notifcations.dart';
import 'package:millions_recipe/screens/all_recipes.dart';
import 'package:millions_recipe/screens/recipesPage.dart';
import 'package:provider/provider.dart';

class NewHome extends StatefulWidget {
  NewHome({Key? key}) : super(key: key);

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  @override
  void initState() {
    super.initState();
  }

  final List<String> _imgs = [
    'assets/Food-1.png',
    'assets/Food-2.png',
    'assets/Food-1.png',
    'assets/Food-2.png',
    'assets/Food-1.png',
  ];

  final List<String> _categories = [
    'Breakfast',
    'Appetizers',
    'Main Dishes',
    'Desserts'
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Hi, Mohammed',
                  style: TextStyle(
                    color: Color(0xff303030),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Let\'s make a masterpiece',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0x80303030),
                  ),
                ),
                SizedBox(
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
          Container(
            height: 44,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: const Color(0xffD9D9D9))),
            child: const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xffD9D9D9),
                ),
                hintText: "Search recipes",
                hintStyle: TextStyle(color: Color(0xffC1C1C1)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                isDense: true,
                suffixIcon: Icon(
                  CupertinoIcons.slider_horizontal_3,
                  color: Color(0xffD9D9D9),
                ),
              ),
            ),
          ),
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _categories.length,
              itemBuilder: (BuildContext context, int index) {
                bool isEven = index % 2 == 0;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        print(index);
                      });
                    },
                    child: Stack(
                      // alignment: Alignment.topCenter,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 100.0 / 4.0),
                          padding: const EdgeInsets.only(top: 100.0 / 2.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xffF1F1F1),
                            ),
                            padding: const EdgeInsets.only(top: 100.0 / 2.0),
                            //replace this Container with your Card
                            width: 150,
                            height: 176.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // give it a padding
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    // make the text center aligned
                                    textAlign: TextAlign.center,
                                    'Pepper sweetcorn ramen',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'Time',
                                            style: TextStyle(
                                              color: Color(0x402E2E2E),
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 8.0,
                                            bottom: 14,
                                          ),
                                          child: Text(
                                            '10 Mins',
                                            style: TextStyle(
                                              color: Color(0xff2E2E2E),
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              right: 10.0, bottom: 10.0),
                                          padding: const EdgeInsets.all(5.0),
                                          width: 30, // adjust size as needed
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: !isEven
                                                ? Color(0xffE23E3E)
                                                : Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/allSVG/Favorite-Icon.svg',
                                            color: isEven
                                                ? const Color(0xff2E2E2E)
                                                : const Color(0xffffffff),
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
                          margin: const EdgeInsets.only(left: 10.0),
                          width: 125.0,
                          height: 125.0,
                          // decoration:
                          //     ShapeDecoration(shape: CircleBorder(), color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 50, // specify the radius of the circle
                              backgroundImage: AssetImage(_imgs[index]),
                              // AssetImage(
                              //     'assets/Food-2.png') // provide the image path
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Recipes',
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print(index);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecipesPage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: 200,
                        width: 150,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                'https://via.placeholder.com/186x200',
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Indonesian chicken burger',
                              style: TextStyle(
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
