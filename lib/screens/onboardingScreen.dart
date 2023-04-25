import 'package:flutter/material.dart';
import 'package:millions_recipe/home.dart';
import 'package:millions_recipe/screens/gender_selection_page.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onDotTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: contents.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          contents[i].image,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        contents[i].title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        contents[i].discription,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_currentIndex == contents.length - 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GenderSelections(),
                    // Home(),
                  ),
                );
              }
              _pageController.nextPage(
                duration: const Duration(milliseconds: 100),
                curve: Curves.bounceIn,
              );
            },
            child: Container(
              margin: const EdgeInsets.all(60),
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
              child: Center(
                child: Text(
                  _currentIndex == contents.length - 1 ? "Continue" : "Next",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildDot(int index, BuildContext context) {
    return GestureDetector(
        onTap: () => _onDotTapped(index),
        child: Container(
          height: 10,
          width: _currentIndex == index ? 25 : 10,
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff53E88B), Color(0xff15BE77)]),
          ),
        ));
  }
}

class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Taste Your Finest Creations',
      image: 'assets/Eating donuts-bro 1.png',
      discription:
          "Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. Aliquam in hendrerit."),
  UnbordingContent(
      title: 'Teaching You The Finest Cuisines ',
      image: 'assets/Baker-bro 1.png',
      discription:
          "Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. Aliquam in hendrerit."),
  UnbordingContent(
      title: 'World-Class Cookery For Your Special Someone',
      image: 'assets/Eating together-bro 1.png',
      discription:
          "Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. Aliquam in hendrerit."),
];
