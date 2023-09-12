import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/constants.dart';

class MeetDevelopers extends StatefulWidget {
  const MeetDevelopers({super.key});

  @override
  State<MeetDevelopers> createState() => _MeetDevelopersState();
}

class _MeetDevelopersState extends State<MeetDevelopers> {
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
          title: const Text("Meet The Team",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ))),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 219,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 28.0,
                  childAspectRatio: 0.9,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Card(
                      // elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/Food-1.png",
                                fit: BoxFit.scaleDown,
                                width: double.infinity,
                                height: 130,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 6, bottom: 3),
                                child: Text(
                                  "John Doe ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const Text("Backed Developer",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/allSVG/mdi_github.svg",
                                      width: 20,
                                      height: 20,
                                    ),
                                    SvgPicture.asset(
                                      "assets/allSVG/logos_linkedin-icon.svg",
                                      width: 20,
                                      height: 20,
                                    ),
                                    SvgPicture.asset(
                                      "assets/allSVG/logos_google-gmail.svg",
                                      width: 19,
                                      height: 19,
                                    )
                                  ],
                                ),
                              )
                            ]),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
