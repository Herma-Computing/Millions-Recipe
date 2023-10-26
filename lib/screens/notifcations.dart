import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/constants.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List nameList = ["All", "Read", "Unread"];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _selectedIndex = 1;

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
            title: Row(
              children: [
                const Text("Notifications",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    )),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.slider_horizontal_3))
              ],
            )),

        // appBar: AppBar(
        //   title: const Text('Notifications'),
        // ),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  titleHeads(1, nameList[0], context),
                  titleHeads(2, nameList[1], context),
                  titleHeads(3, nameList[2], context),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Today",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 14),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 13.0, bottom: 11),
                      child: ListTile(
                        leading: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.request_page_outlined,
                                color: Colors.green,
                              ),
                            )),
                        title: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("New recipe!",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                )),
                            Text(
                                "Far far away, behind the word mountains, far from the countries.",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ))
                          ],
                        ),
                        trailing: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green)),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )));
  }

  GestureDetector titleHeads(int index, String name, BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        width: 95,
        height: 35,
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          gradient: _selectedIndex == index
              // true
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
            name,
            style: TextStyle(
              //TODO
              color: _selectedIndex == index
                  // true
                  ? Theme.of(context).colorScheme.background
                  : const Color(0xff53E88B),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
