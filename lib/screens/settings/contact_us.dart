import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/constants.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Contact us',
          style: TextStyle(
            // color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/allSVG/Contact Us.svg",
              alignment: Alignment.topCenter,
              width: 242,
              height: 246,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 47.0, bottom: 4),
              child: Text("How can we help you",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                  textAlign: TextAlign.center,
                  "It looks like you’re having some trouble \nwith our app. We’re here to help",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0, bottom: 21),
                    child: reusabletextField("Subject"),
                  ),
                  reusabletextField("Email"),
                  Padding(
                    padding: const EdgeInsets.only(top: 21.0, bottom: 27),
                    child: Container(
                      // height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1, color: const Color(0xffD9D9D9))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 15),
                        child: Center(
                          child: TextField(
                            cursorColor: kPrimaryColor,
                            maxLines: 20,
                            minLines: 7,
                            decoration: const InputDecoration(
                              hintText: "Message",
                              contentPadding:
                                  EdgeInsetsDirectional.only(start: 4),
                              hintStyle: TextStyle(color: Color(0xffC1C1C1)),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //TODO
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 16),
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
                      child: const Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Container reusabletextField(String hint) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: const Color(0xffD9D9D9))),
      child: Center(
        child: TextField(
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsetsDirectional.only(start: 4),
            hintStyle: const TextStyle(color: Color(0xffC1C1C1)),
            border: InputBorder.none,
            isDense: true,
          ),
        ),
      ),
    );
  }
}
