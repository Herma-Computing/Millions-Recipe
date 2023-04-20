import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 26, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 2, color: Colors.grey)),
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search recipes",
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    isDense: true,
                    suffixIcon: Icon(CupertinoIcons.slider_horizontal_3),
                    suffixIconColor: Colors.grey,
                    prefixIconColor: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "12 Recipes found",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Resuable_Card(),
                );
              },
            ),
          )
        ]),
      ),
    );
  }

  Expanded Resuable_Card() {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.only(left: 22, right: 30),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
          padding: EdgeInsets.all(11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment(1, -1),
                child: Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.red,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 128,
                      height: 155,
                      child: Image(image: AssetImage("assets/pancake.png"))),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Home made cute pancake",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        reusableRow("2 people", Icons.people_outline),
                        reusableRow("10 - 15 mins", Icons.access_time),
                        reusableRow("350kcal", CupertinoIcons.flame),
                        Row(
                          children: [
                            // Checkbox(
                            //   activeColor: Color(0xff53E88B),
                            //   value: true,
                            //   onChanged: (value) {},
                            // ),

                            Icon(
                              Icons.check_box_outlined,
                              color: Color(0xff53E88B),
                            ),

                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: Text(
                                "You have all the ingredients",
                                style: TextStyle(
                                    color: Color(0xff53E88B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  // todo:
                  //
                },
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  width: 208.47,
                  height: 44,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Color(0xff15BE77),
                          Color(0xff53E88B),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Show Recipe",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row reusableRow(String txt, IconData ico) {
    return Row(
      children: [
        Icon(ico),
        SizedBox(
          width: 8,
        ),
        Text(
          txt,
          style: TextStyle(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
