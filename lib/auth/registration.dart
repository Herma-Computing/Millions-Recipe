import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:millions_recipe/api_service/api_provider.dart';
import 'login.dart';
import 'otp_verification.dart';

bool isPressed = true;
bool others = false;
bool passwd = true;

String? fnameError, lnameError, emailError, passwordError;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool checked = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();

    super.dispose();
  }

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            Image.asset('assets/logo.png'),
            const Text(
              "Let's get you set up",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff2E2E2E),
                  fontWeight: FontWeight.w500),
            ),
            const Text(
              "Create an account",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 38,
            ),
            reusableTextField(
                "First Name",
                Icons.person_outline,
                null,
                others,
                firstnameController,
                TextInputType.text,
                validateFirstName,
                fnameError),
            reusableTextField(
                "Last Name",
                Icons.person_outline,
                null,
                others,
                lastnameController,
                TextInputType.text,
                validateLastName,
                lnameError),
            reusableTextField(
                "Email",
                Icons.email_outlined,
                null,
                others,
                emailController,
                TextInputType.emailAddress,
                validateEmail,
                emailError),
            reusableTextField(
                "Password",
                Icons.lock_outline,
                Icons.visibility_off_outlined,
                passwd,
                passwordController,
                TextInputType.text,
                validatePassword,
                passwordError),
            Container(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: checked,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onChanged: (value) {
                    setState(() {
                      checked = !checked;
                    });
                  },
                ),
                const Text(
                  maxLines: 3,
                  "By continuing you accept our Privacy\n Policy and Term of Use",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                //
                if (checked) {
                  register();
                } else {
                  Fluttertoast.showToast(
                    msg: "you have to accept terms and conditions",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: const Color.fromARGB(255, 76, 148, 79),
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                width: 206,
                height: 54,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color(0xff15BE77),
                        Color(0xff53E88B),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text(
                    "Signup",
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Colors.grey,
                      height: 1,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Or",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Colors.grey,
                      height: 1,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => signin(),
                    child: Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 2,
                                color:
                                    const Color.fromARGB(208, 178, 178, 178))),
                        child: Image.asset("assets/google_logo.png")),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LogIn(),
                      ),
                    );
                  },
                  child: const Text(" Login",
                      style: TextStyle(
                          color: Color(0xff53E88B),
                          fontSize: 17,
                          fontWeight: FontWeight.w700)),
                )
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: "Wanna have a look?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400)),
                TextSpan(
                    text: " Skip",
                    style: TextStyle(
                        color: Color(0xff53E88B),
                        fontSize: 17,
                        fontWeight: FontWeight.w700))
              ]),
            ),
            const SizedBox(
              height: 37,
            )
          ],
        ),
      ),
    );
  }

  Future signin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final user = await googleSignIn.signIn();
      String? name = "";
      //String? image = "";
      if (user!.displayName != null) {
        name = user.displayName;
      }

      String res = await ApiProvider()
          .registerUser(user.email, name!, name, user.id, "google");
      if (res == "success") {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Otp(email: emailController.text),
        ));
      } else {
        // ignore: use_build_context_synchronously
        Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
          titleSize: 20,
          messageSize: 17,
          //backgroundColor: maincolor,
          borderRadius: BorderRadius.circular(8),
          message: res,
          duration: const Duration(seconds: 5),
        ).show(context);
      }
    } catch (error) {
      await googleSignIn.disconnect();
    }
  }

  Future<void> register() async {
    String? emailError = validateEmail(emailController.text);
    String? passwordError = validatePassword(passwordController.text);
    String? firstnameError = validateFirstName(firstnameController.text);
    String? lastnameError = validateLastName(lastnameController.text);
    String msg = 'Check informations that you have provided.';

    if (emailError != null ||
        passwordError != null ||
        firstnameError != null ||
        lastnameError != null) {
      if (emailError == null &&
          passwordError != null &&
          firstnameError == null &&
          lastnameError == null) {
        msg = passwordError;
      } else if (emailError != null &&
          passwordError == null &&
          firstnameError == null &&
          lastnameError == null) {
        msg = emailError;
      } else if (emailError == null &&
          passwordError == null &&
          firstnameError != null &&
          lastnameError == null) {
        msg = firstnameError;
      } else if (emailError == null &&
          passwordError == null &&
          firstnameError == null &&
          lastnameError != null) {
        msg = lastnameError;
      }
      setState(() {
        firstnameError = firstnameError;
        lastnameError = lastnameError;
        emailError = emailError;
        passwordError = passwordError;
      });

      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      String res = await ApiProvider().registerUser(
        emailController.text,
        firstnameController.text,
        lastnameController.text,
        passwordController.text,
        'email_password',
      );

      if (res == "success") {
        Fluttertoast.showToast(
          msg: res,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Otp(email: emailController.text),
        ));
      } else {
        // ignore: use_build_context_synchronously
        Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
          titleSize: 20,
          messageSize: 17,
          borderRadius: BorderRadius.circular(8),
          message: res,
          duration: const Duration(seconds: 5),
        ).show(context);
      }
    } catch (e) {
      Navigator.of(context).pop();

      Flushbar(
        flushbarPosition: FlushbarPosition.BOTTOM,
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
        titleSize: 20,
        messageSize: 17,
        borderRadius: BorderRadius.circular(8),
        message: 'An error occurred',
        duration: const Duration(seconds: 5),
      ).show(context);
    }
  }

  Container reusableTextField(
      String hintText,
      IconData icons,
      IconData? suffixicon,
      bool hide,
      TextEditingController controller,
      TextInputType keybordtype,
      String? Function(String?)? validator,
      String? errorMessage) {
    Color secondbackgroundColor = Theme.of(context).cardColor;
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(10));
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ThemeData().colorScheme.copyWith(
                    // ignore: use_full_hex_values_for_flutter_colors
                    primary: const Color(0xff2E2E2E40),
                    secondary: Colors.white),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: errorMessage != null
                      ? Colors.red[50]
                      : secondbackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: controller,
                  obscureText: hide,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    errorText: errorMessage,
                    prefixIcon: Icon(
                      icons,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (suffixicon != null) {
                              isPressed = !isPressed;
                              passwd = !passwd;
                            }
                          });
                        },
                        icon: (suffixicon != null)
                            ? (isPressed)
                                ? const Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.grey,
                                  )
                                : const Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.grey,
                                  )
                            : const Icon(null)),
                    // ignore: use_full_hex_values_for_flutter_colors
                    prefixIconColor: const Color(0xff2E2E2E40),
                    // ignore: use_full_hex_values_for_flutter_colors
                    iconColor: const Color(0xff2E2E2E40),
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: secondbackgroundColor,
                    filled: true,
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    errorStyle: const TextStyle(fontSize: 0.01),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: textTheme.displayMedium
                      ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                  keyboardType: keybordtype,
                  textInputAction: TextInputAction.next,
                  validator: validator,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      fnameError = 'First name is required';
      return fnameError;
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      lnameError = 'Last name is required';
      return lnameError;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value != null && !value.contains('@') || !value!.contains('.')) {
      emailError = "Enter a valid Email";
      return emailError;
    } else {
      emailError = null;
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value != null && value.isEmpty) {
      passwordError = 'Enter a password';
      return passwordError;
    } else if (value!.length < 8) {
      passwordError = 'password length can\'t be lessthan 8';
      return passwordError;
    } else {
      passwordError = null;
      return null;
    }
  }
}
