// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../common/constants.dart';

// ignore: must_be_immutable
class CookingSteps extends StatelessWidget {
  var recipeStep;
  CookingSteps({super.key, required this.recipeStep});
  @override
  Widget build(BuildContext context) {
    final stepListJson = recipeStep['step'] as String;
    final List<dynamic> stepList = jsonDecode(stepListJson);
    double cWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      backgroundColor: Colors.grey[50],
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
          'Cooking Steps',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: ListView.builder(
            itemCount: stepList.length,
            itemBuilder: (context, index) {
              final stepItem = stepList[index];
              return Column(
                children: [
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ((index + 1) % 2 == 0)
                              ? toogleStep(cWidth, stepItem['step'], index)
                              : toogleIndex(index),
                          const SizedBox(
                            width: 18,
                          ),
                          ((index + 1) % 2 == 0)
                              ? toogleIndex(index)
                              : toogleStep(cWidth, stepItem['step'], index),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  index > stepList.length
                      ? const SizedBox()
                      : stepItem['step'] == ""
                          ? const SizedBox()
                          : stepItem['image_url'] != null &&
                                  stepItem['image_url'] != ""
                              ? Container(
                                  width: (cWidth / 0.8) - 48,
                                  height: 180,
                                  child: Image.file(
                                    File(stepItem['image_url']),
                                    fit: BoxFit.scaleDown,
                                  ),
                                )
                              : const SizedBox(),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  SizedBox toogleStep(double cWidth, String steps, int index) {
    return SizedBox(
      width: cWidth - 16,
      child: Column(
        children: <Widget>[
          Text(
            steps,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }

  Container toogleIndex(int index) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: kPrimaryColor,
      ),
      child: Text(
        "${index + 1}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
