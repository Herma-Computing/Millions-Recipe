import 'package:flutter/material.dart';

import 'package:millions_recipe/screens/profile/profile.dart';
import '../../common/constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            // color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    // alignment: Alignment.center,
                    children: [
                      SizedBox(
                          height: 110,
                          width: 110,
                          child: CircleAvatar(
                            child: Image.asset("assets/Ellipse 7.png"),
                          )),
                      Positioned(
                        right: 5,
                        bottom: 8,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.black,
                            size: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text("Update your photo",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSecondary)),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 37, left: 28, right: 30, bottom: 100),
                    child: Column(
                      children: [
                        reusableTextField(context, "First name"),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 21),
                          child: reusableTextField(context, "Last name"),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 150,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: const Color(0xffD9D9D9))),
                              child: Center(
                                child: TextField(
                                  cursorColor: kPrimaryColor,
                                  decoration: const InputDecoration(
                                    hintText: "Gender",
                                    hintStyle:
                                        TextStyle(color: Color(0xffC1C1C1)),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Container(
                              height: 48,
                              width: 150,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: const Color(0xffD9D9D9))),
                              child: Center(
                                child: TextField(
                                  cursorColor: kPrimaryColor,
                                  decoration: const InputDecoration(
                                    hintText: "Birthday",
                                    hintStyle:
                                        TextStyle(color: Color(0xffC1C1C1)),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 21),
                          child: reusableTextField(context, "Email"),
                        ),
                        reusableTextField(context, "Title"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Profile(),
                        ),
                      );
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
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

  Container reusableTextField(BuildContext context, String hint) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: const Color(0xffD9D9D9))),
      child: Center(
        child: TextField(
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xffC1C1C1)),
            border: InputBorder.none,
            isDense: true,
          ),
        ),
      ),
    );
  }
}
