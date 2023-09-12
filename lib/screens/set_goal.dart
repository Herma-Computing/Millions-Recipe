import 'package:flutter/material.dart';

import 'gender_selection_page.dart';

class SetGoal extends StatefulWidget {
  const SetGoal({super.key});

  @override
  State<SetGoal> createState() => _SetGoalState();
}

class _SetGoalState extends State<SetGoal> {
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
          title: const Text("Help us show \nrelevant recipes",
              style: TextStyle(
                fontSize: 24,
                // color: Colors.black,
                fontWeight: FontWeight.w800,
              ))),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text("Get personalized experience",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff2E2E2E80),
                      fontWeight: FontWeight.w500,
                    )),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 34, bottom: 19),
                  child: Text("Select any diets you follow",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ))),
              SizedBox(
                height: 38,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index < 2) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: reusableContainer(),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Container(
                              width: 96,
                              height: 34,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black54)),
                              child: const Center(
                                child: Text("Atkins",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )),
                              )),
                        );
                      }
                    }),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 38, bottom: 19),
                  child: Text("Select cooking time",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ))),
              SizedBox(
                height: 38,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index < 2) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: reusableContainer(),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Container(
                              width: 96,
                              height: 34,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black54)),
                              child: const Center(
                                child: Text("Atkins",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )),
                              )),
                        );
                      }
                    }),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 38, bottom: 19),
                  child: Text("Select any allergies you may have",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ))),
              SizedBox(
                height: 38,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index < 2) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: reusableContainer(),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Container(
                              width: 96,
                              height: 34,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black54)),
                              child: const Center(
                                child: Text("Atkins",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )),
                              )),
                        );
                      }
                    }),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 38, bottom: 19),
                  child: Text("What is your fitness goal",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ))),
              SizedBox(
                height: 38,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index < 2) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: reusableContainer(),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Container(
                              width: 96,
                              height: 34,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black54)),
                              child: const Center(
                                child: Text("Atkins",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )),
                              )),
                        );
                      }
                    }),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 38, bottom: 19),
                  child: Text("What is your ideal water intake",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ))),
              SizedBox(
                height: 38,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index < 2) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: reusableContainer(),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Container(
                              width: 96,
                              height: 34,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black54)),
                              child: const Center(
                                child: Text("Atkins",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )),
                              )),
                        );
                      }
                    }),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GenderSelections(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 15),
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
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class reusableContainer extends StatelessWidget {
  const reusableContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 96,
        height: 34,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff53e78b), Color(0xff14be77)],
            )),
        child: const Center(
          child: Text("Vegan",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              )),
        ));
  }
}
