// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:millions_recipe/screens/profile/profile.dart';
import '../../api/shared_preference/shared_preference.dart';
import '../../api_service/api_provider.dart';
import '../../common/constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  List initialText = [];

  String? token;
  String? fnameError,
      lnameError,
      emailError,
      occupationError,
      birthdayError,
      genderError;
  String? filePath;
  String? fileUrl;
  File? selectedImage;

  @override
  void initState() {
    token = UserPreferences.getToken();
    fileUrl = UserPreferences.getProfilePicture();

    firstNameController.text = UserPreferences.getName() ?? '';
    lastNameController.text = UserPreferences.getuserProfile()[1] ?? '';
    birthdateController.text = UserPreferences.getuserProfile()[4] ?? '';
    emailController.text = UserPreferences.getuserProfile()[2] ?? '';
    occupationController.text = UserPreferences.getuserProfile()[5] ?? '';
    genderController.text = UserPreferences.getuserProfile()[3] ?? '';

    initialText.addAll([
      firstNameController.text,
      lastNameController.text,
      birthdateController.text,
      emailController.text,
      occupationController.text,
      genderController.text
    ]);

    super.initState();
  }

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
                  GestureDetector(
                    onTap: () {
                      // filePath = await pickImage();
                      pickImage();
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                            height: 110,
                            width: 110,
                            child: ClipOval(
                                child: selectedImage != null
                                    ? Image.file(
                                        selectedImage!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        fileUrl!,
                                        fit: BoxFit.cover,
                                      )
                                // Image.asset("assets/Ellipse 7.png"),
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
                        reusableTextField(
                          context,
                          "First name",
                          firstNameController,
                          fnameError,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }

                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 21),
                          child: reusableTextField(
                            context,
                            "Last name",
                            lastNameController,
                            lnameError,
                            (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }

                              return null;
                            },
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: MediaQuery.sizeOf(context).width * 0.368,
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
                                  controller: genderController,
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
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.1,
                            ),
                            Container(
                              height: 48,
                              width: MediaQuery.sizeOf(context).width * 0.368,
                              // width: 150,
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
                                  controller: birthdateController,
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
                          child: reusableTextField(
                            context,
                            "Email",
                            emailController,
                            emailError,
                            (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address';
                              }

                              return null;
                            },
                          ),
                        ),
                        reusableTextField(
                          context,
                          "Title",
                          occupationController,
                          occupationError,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill the field';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // setImage();

                      emailError = validateEmail(emailController.text);
                      occupationError =
                          validateOccopation(occupationController.text);
                      fnameError = validateName(firstNameController.text);
                      lnameError = validateName(lastNameController.text);
                      birthdayError = validateBirth(birthdateController.text);
                      genderError = validateGender(genderController.text);

                      if (emailError == null &&
                          occupationError == null &&
                          fnameError == null &&
                          lnameError == null &&
                          birthdayError == null &&
                          genderError == null) {
                        updateInformation();
                      }
                      // else if()
                      else {
                        setState(() {});

                        Flushbar(
                          flushbarPosition: FlushbarPosition.BOTTOM,
                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                          titleSize: 20,
                          messageSize: 17,
                          borderRadius: BorderRadius.circular(8),
                          message: fnameError ??
                              lnameError ??
                              genderError ??
                              birthdayError ??
                              emailError ??
                              occupationError,
                          duration: const Duration(seconds: 5),
                        ).show(context);
                      }
                    },
                    child: Container(
                      // margin: const EdgeInsets.only(top: 0),
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

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
        filePath = pickedImage.path;
      });
    }
  }

  void updateInformation() async {
    if (initialText ==
        [
          firstNameController.text,
          lastNameController.text,
          birthdateController.text,
          emailController.text,
          occupationController.text,
          genderController.text
        ]) {
      if (filePath != null) {
        setImage();
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Profile(),
        ),
      );
    } else if (token != null) {
      if (filePath != null) {
        setImage();
      }
      String res = await ApiProvider().profilePatch(
          firstNameController.text,
          lastNameController.text,
          birthdateController.text,
          occupationController.text,
          genderController.text,
          token!);
      Navigator.pop(context);
      if (res == "200") {
        Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
          titleSize: 20,
          messageSize: 17,
          backgroundColor: Colors.green,
          borderRadius: BorderRadius.circular(8),
          message: "Your profile is updated!",
          duration: const Duration(seconds: 5),
        ).show(context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Profile(),
          ),
        );
      }
    } else {
      Flushbar(
        flushbarPosition: FlushbarPosition.BOTTOM,
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
        titleSize: 20,
        messageSize: 17,
        borderRadius: BorderRadius.circular(8),
        message: "Your profile could not be updated, please try again.",
        duration: const Duration(seconds: 5),
      ).show(context);
    }
  }

  String? validateEmail(String value) {
    final emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    // if (value.isEmpty) {
    //   emailError = "Please enter a valid email address (ex. abc@gmail.com)";
    if (value.isEmpty || emailRegex.hasMatch(value) == false) {
      return 'Please enter Valid phone number';
    }

    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty || value.length < 3) {
      return "Please enter your name (Minimum of 3 characters)";
    }
    return null;
  }

  String? validateGender(String value) {
    if (value.isEmpty ||
        (value.toLowerCase() != "male" && value.toLowerCase() != "female")) {
      return "Please enter your valid Gender";
    }
    return null;
  }

  String? validateOccopation(String value) {
    final ocupationRegex = RegExp(r'^([^0-9]*)$');
    if (ocupationRegex.hasMatch(value) == false) {
      return "Please enter a valid occupation (ex. Student, Engineer)";
    }
    return null;
  }

  String? validateBirth(String value) {
    if (value.isEmpty) {
      return "Please enter valid Date";
    }
    return null;
  }

  void setImage() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => const Center(
        child: CircularProgressIndicator(color: Colors.blue),
      ),
    );

    if (filePath != null && token != null) {
      try {
        String imageUrl =
            await ApiProvider().changeProfilePicture(filePath!, token);
        setState(() {});
        UserPreferences.setProfilePicture(imageUrl);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to upload image. Try again later."),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid file selected."),
        ),
      );
    }

    Navigator.pop(context);
  }

  Container reusableTextField(
    BuildContext context,
    String hint,
    TextEditingController controller,
    String? errorText,
    String? Function(String?)? validator,
  ) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: const Color(0xffD9D9D9))),
      child: Center(
        child: TextFormField(
          validator: validator,
          controller: controller,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            errorText: errorText,
            errorStyle: const TextStyle(fontSize: 0.01),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(50),
            ),
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
