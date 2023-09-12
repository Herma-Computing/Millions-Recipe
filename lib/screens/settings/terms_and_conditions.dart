import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/constants.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

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
          'Terms and Services',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 58.0),
              child: SvgPicture.asset('assets/allSVG/freelancer.svg'),
            )),
            const SizedBox(
              height: 40,
            ),
            const Center(
                child: Text(
              "Terms and Conditions",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )),
            const SizedBox(
              height: 38,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 34),
              child: termsText(
                  '1. There must to be sufficient detail in the content. To make the lesson content easier for readers to understand, please provide more descriptions.'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: termsText(
                  '2. The lesson material should not contain any contact hashtags or lengthy descriptions unless absolutely essential'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 34),
              child:
                  termsText('3.Avoid misspellings and ambiguous information.'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: termsText('4. Must follow proper formatting'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  shape: const CircleBorder(),
                  focusColor: Colors.greenAccent,
                  hoverColor: Colors.greenAccent,
                  onChanged: (bool? value) {},
                  value: true,
                ),
                termsText("Accept terms and Condtions")
              ],
            ),
            const SizedBox(
              height: 98,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
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
                    "Accept & Continue",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text termsText(String text) => Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      );
}
