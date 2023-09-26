import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import 'package:millions_recipe/screens/recipes_page.dart';
import '../../api/shared_preference/shared_preference.dart';
import '../../common/constants.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  late String fileUrl;
  @override
  void initState() {
    fileUrl = UserPreferences.getProfilePicture()!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
          child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff53e78b), Color(0xff14be77)],
            )),
        child: const Icon(Icons.add),
      )),
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
          'Forum',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 25),
            child: topSearchBar(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              forumCategories("Newest", true),
              forumCategories("Featured", false),
              forumCategories("Oldest", false),
            ],
          ),
          const SizedBox(height: 37),
          Expanded(
              child: ListView.builder(
            itemCount: 13,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 19),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 13.0, right: 20, top: 10, bottom: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                    fileUrl,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Mohammed Ibrahim",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    Text("Junior Chef",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ))
                                  ],
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10, top: 14),
                              child: Text("Lorem Ipsum dolor sit amet",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            ReadMoreText(
                              textAlign: TextAlign.start,
                              "If you’re offered a seat on a rocket ship, don’t \nask what seat! Just get on board and move \nthe sail towards the destination. Lorem ipsum dolor sit amet consectetur. Ullamcorper porttitor arcu eros elit libero. Consequat ipsum accumsan rhoncus tortor. Aliquet placerat non urna egestas lacus porta neque blandit eget. Placerat tellus quis montes id in ut mattis. Feugiat nunc purus turpis sodales. Aliquam elit in elit eu congue quam gravida",
                              trimLines: 2,
                              colorClickableText: Colors.pink,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '\nShow more',
                              trimExpandedText: '\nShow less',
                              style: const TextStyle(fontSize: 12),
                              lessStyle: TextStyle(
                                  fontSize: 13,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              moreStyle: TextStyle(
                                  fontSize: 13,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                            // const Text(
                            //     "Lorem ipsum dolor sit amet consectetur. Ullamcorper porttitor arcu eros elit libero. Consequat ipsum accumsan rhoncus tortor. Aliquet placerat non urna egestas lacus porta neque blandit eget. Placerat tellus quis montes id in ut mattis. Feugiat nunc purus turpis sodales. Aliquam elit in elit eu congue quam gravida... Read More",
                            //     style: TextStyle(
                            //       fontSize: 10,
                            //       fontWeight: FontWeight.w500,
                            //     )),
                            const SizedBox(
                              height: 8,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("#Appitizers",
                                    style: TextStyle(
                                      color: Color(0xff53E88B),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text("#Dessert",
                                    style: TextStyle(
                                      color: Color(0xff53E88B),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text("#Bake",
                                    style: TextStyle(
                                      color: Color(0xff53E88B),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                bottomIcons(Icons.favorite_outline_sharp),
                                const SizedBox(
                                  width: 8,
                                ),
                                bottomIcons(Icons.insert_comment_outlined),
                                const Spacer(),
                                bottomIcons(
                                    Icons.subdirectory_arrow_right_rounded),
                                const SizedBox(
                                  width: 8,
                                ),
                                bottomIcons(Icons.more_horiz_sharp),
                              ],
                            )
                          ]),
                    ),
                  ),
                ),
              );
            },
          ))
        ],
      )),
    );
  }

  Container bottomIcons(IconData icon) {
    return Container(
      // width: 20,
      // height: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0x3f53e88b)),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 15),
      ),
    );
  }

  Padding forumCategories(String name, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Container(
          width: 96,
          height: 34,
          decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xff53e78b), Color(0xff14be77)],
                    )
                  : null,
              borderRadius: BorderRadius.circular(10),
              border: !isSelected
                  ? Border.all(color: Theme.of(context).colorScheme.onSecondary)
                  : null),
          child: Center(
            child: Text(name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
          )),
    );
  }
}
