import 'dart:ffi';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final data = [
    "Breakfast",
    "Appetizers",
    "Dinner",
    "Lunch",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "three",
    "four",
    "five",
  ];
  final mini = [
    "10 Mins",
    "20 Mins",
    "30 Mins",
    "40 Mins",
    "50 Mins",
  ];
  final data2 = [
    "Indeonesial Chicken burger",
    "Home made cute pancake",
    "How to make seafood fried",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "three",
    "four",
    "five",
    "six",
  ];
  List imagess = [
    // 'photo-1.jpeg',
    // "photo-2.jpeg",
    // "photo-3.jpeg",
    // "photo-4.jpeg",
    // "photo-5.jpeg",
    // "photo-5.jpeg",
    // "photo-6.jpeg",
    // Image.asset("photo-7.jpeg"),
    // Image.asset("photo-7.jpeg"),
    // Image.asset("photo-7.jpeg"),
    "assets/images/photo-2.jpeg",
    "assets/images/photo-1.jpeg",
    "assets/images/photo-3.jpeg",
    "assets/images/photo-4.jpeg",
    "assets/images/photo-5.jpeg",
    "assets/images/photo-6.jpeg",
    "assets/images/photo-7.jpeg",
    "assets/images/photo-8.jpeg",
    "assets/images/photo-9.jpeg",
  ];
  int indexx = 0;
  // int indexxx = indexx+  1;
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hi, Mohammed",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: -35,
                          left: 14,
                          child: Text(
                            ".",
                            style: TextStyle(
                                fontSize: 40, color: Colors.greenAccent),
                          ),
                        ),
                        Icon(Icons.notifications_outlined),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Let's make a masterpiece",
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                        width: 400,
                        height: 40,
                        // Add padding around the search bar
                        // padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        // Use a Material design search bar
                        child: TextField(
                            // controller: _searchController,
                            decoration: InputDecoration(
                          hintText: 'Search...',
                          // Add a clear button to the search bar
                          suffixIcon: IconButton(
                              icon: Icon(Icons.clear), onPressed: () {}),
                          // Add a search icon or button to the search bar
                          prefixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              // Perform the search here
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ))),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "popular category",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ]),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      itemCount: data.length,
                      scrollDirection: Axis.horizontal,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 100,
                          height: 10,
                          // color: Colors.yellow,
                          margin: const EdgeInsets.all(8),
                          child: Center(
                              child: TextButton(
                                  style: ButtonStyle(
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.greenAccent)),
                                  onPressed: () {
                                    setState(() {
                                      pressed = !pressed;
                                    });
                                  },
                                  child: Text(
                                    data[index],
                                    style: pressed
                                        ? TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            color: Colors.greenAccent,
                                            fontWeight: FontWeight.bold),
                                  ))),
                        );
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: ListView.builder(
                        // physics: const BouncingScrollPhysics(
                        //     parent: AlwaysScrollableScrollPhysics()),
                        itemCount: imagess.length,
                        shrinkWrap: true,
                        // physics: const ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 160,
                            margin: const EdgeInsets.all(8),
                            child: Center(
                                child: Stack(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color.fromRGBO(
                                          83, 232, 139, 0.1),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Positioned(
                                        top: -120 / 2,
                                        child: Container(
                                            width: 110,
                                            height: 105,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        imagess[index])))),
                                      ),
                                      Text(data[indexx++]),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25, right: 110),
                                        child: Text(
                                          "Time",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 10),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 100),
                                            child: Text(
                                              mini[index++],
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ),
                                          Icon(
                                            Icons.favorite_border_outlined,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ])),
                          );
                        }),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Recipes",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "sea all ->",
                        style: TextStyle(color: Colors.greenAccent),
                      ),
                    ]),
                Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        child: ListView.builder(
                            // physics: const BouncingScrollPhysics(
                            //     parent: AlwaysScrollableScrollPhysics()),
                            itemCount: imagess.length,
                            shrinkWrap: true,
                            // physics: const ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 165,
                                margin: const EdgeInsets.all(8),
                                child: Center(
                                    child: Stack(
                                        alignment: Alignment.center,
                                        clipBehavior: Clip.none,
                                        children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: const Color.fromRGBO(
                                              83, 232, 139, 0.1),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Positioned(
                                            top: -3,
                                            child: Container(
                                                width: 165,
                                                height: 85,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            imagess[index])))),
                                          ),
                                          Text(
                                            data2[indexx++],
                                            style: TextStyle(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          )
                                        ],
                                      )
                                    ])),
                              );
                            }),
                      ),
                    ])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
