import 'package:another_flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import 'package:millions_recipe/auth/registration.dart';
import '../api_service/api_provider.dart';
import '../landing.dart';
import 'forgot_password.dart';

bool isPressed = true;
bool isPasswd = true;

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
            const SizedBox(
              height: 36,
            ),
            const Text(
              "Hey there,",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff2E2E2E),
                  fontWeight: FontWeight.w500),
            ),
            const Text(
              "Welcome Back",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 38,
            ),
            Reusable_TextField("Email", Icons.email_outlined, null,
                emailController, TextInputType.emailAddress, false),
            Reusable_TextField(
                "Password",
                Icons.lock_outline,
                Icons.visibility_off_outlined,
                passwordController,
                TextInputType.text,
                isPasswd),
            Container(),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ForgotPassword(),
                ));
              },
              child: RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: "Forgot",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: " Password?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500))
                ]),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                // todo:
                login();
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
                    "Login",
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
                    child: Container(
                      color: Colors.grey,
                      height: 1,
                    ),
                    flex: 1,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Or",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Container(
                      color: Colors.grey,
                      height: 1,
                    ),
                    flex: 1,
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
                    onTap: () {},
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
              height: 28,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Register(),
                      ),
                    );
                  },
                  child: const Text(" Signup",
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
              height: 130,
            )
          ],
        ),
      ),
    );
  }

  Future login() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    String res = await ApiProvider().loginUser(
        emailController.text, passwordController.text, 'email_password');

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
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Landing(),//GenderSelections(),
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
  }

  Container Reusable_TextField(
      String hintText,
      IconData icons,
      IconData? suffixicon,
      TextEditingController controller,
      TextInputType keybordtype,
      bool hide) {
    Color secondbackgroundColor = Theme.of(context).cardColor;
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(
          context,
        ),
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
                    primary: const Color(0xff2E2E2E40),
                    secondary: Colors.white),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: secondbackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                    obscureText: hide,
                    controller: controller,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        icons,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPressed = !isPressed;
                              isPasswd = !isPasswd;
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
                      prefixIconColor: const Color(0xff2E2E2E40),
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
                    validator: (value) {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
