import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'set_goal.dart';

class AddIngredients extends StatefulWidget {
  const AddIngredients({super.key});

  @override
  State<AddIngredients> createState() => _AddIngredientsState();
}

class _AddIngredientsState extends State<AddIngredients> {
  Color kPrimaryColor = const Color(0xFF27AE60);
  @override
  Widget build(BuildContext context) {
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
          title: const Text("Enter ingredients \nin your fridge",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ))),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 8,
                ),
                const Text("Get recipes based on your ingredients",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 34, bottom: 19),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/testAssets/vegtaable.svg"),
                      const SizedBox(
                        width: 13,
                      ),
                      const Text("Vegetables ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ))
                    ],
                  ),
                ),
                const Row(
                  children: [
                    reusableContainer(
                      theImage:
                          "assets/testAssets/tomato-basic-knives-and-their-uses-1 1.png",
                      footer: "Tomato",
                      color: Color(0xff53e88b),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: reusableContainer(
                        theImage: "assets/testAssets/carrot.png",
                        footer: "Carrot",
                        color: Colors.transparent,
                      ),
                    ),
                    reusableContainer(
                      theImage:
                          "assets/testAssets/tomato-basic-knives-and-their-uses-1 1.png",
                      footer: "Tomato",
                      color: Color(0xff53e88b),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: reusableContainer(
                        theImage: "assets/testAssets/carrot.png",
                        footer: "Carrot",
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 19),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/testAssets/diary.svg"),
                      const SizedBox(
                        width: 13,
                      ),
                      const Text("Diary ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ))
                    ],
                  ),
                ),
                const Row(
                  children: [
                    reusableContainer(
                      theImage: "assets/testAssets/milk.png",
                      footer: "Milk",
                      color: Color(0xff53e88b),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: reusableContainer(
                        theImage: "assets/testAssets/yellow_cheese.png",
                        footer: "Cheese",
                        color: Colors.transparent,
                      ),
                    ),
                    reusableContainer(
                      theImage: "assets/testAssets/eggs.png",
                      footer: "Eggs",
                      color: Color(0xff53e88b),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: reusableContainer(
                        theImage: "assets/testAssets/milk.png",
                        footer: "Milk",
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 19),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/testAssets/veg.svg"),
                      const SizedBox(
                        width: 13,
                      ),
                      const Text("Fruits ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ))
                    ],
                  ),
                ),
                const Row(
                  children: [
                    reusableContainer(
                      theImage: "assets/testAssets/banana.png",
                      footer: "Banana",
                      color: Color(0xff53e88b),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: reusableContainer(
                        theImage: "assets/testAssets/apple.png",
                        footer: "Apple",
                        color: Colors.transparent,
                      ),
                    ),
                    reusableContainer(
                      theImage: "assets/testAssets/frute.png",
                      footer: "Strawberry",
                      color: Color(0xff53e88b),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: reusableContainer(
                        theImage: "assets/testAssets/banana.png",
                        footer: "Banana",
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 34, bottom: 19),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/testAssets/vegtaable.svg"),
                      const SizedBox(
                        width: 13,
                      ),
                      const Text("Vegetables ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ))
                    ],
                  ),
                ),
                const Row(
                  children: [
                    reusableContainer(
                      theImage:
                          "assets/testAssets/tomato-basic-knives-and-their-uses-1 1.png",
                      footer: "Tomato",
                      color: Color(0xff53e88b),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: reusableContainer(
                        theImage: "assets/testAssets/carrot.png",
                        footer: "Carrot",
                        color: Colors.transparent,
                      ),
                    ),
                    reusableContainer(
                      theImage:
                          "assets/testAssets/tomato-basic-knives-and-their-uses-1 1.png",
                      footer: "Tomato",
                      color: Color(0xff53e88b),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: reusableContainer(
                        theImage: "assets/testAssets/carrot.png",
                        footer: "Carrot",
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SetGoal(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 35, bottom: 20),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class reusableContainer extends StatelessWidget {
  final String theImage;
  final String footer;
  final Color color;

  const reusableContainer(
      {super.key,
      required this.theImage,
      required this.footer,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: color),
              child: Center(
                child: Image.asset(theImage),
              )),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(footer,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}
