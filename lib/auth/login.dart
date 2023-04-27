import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import '../screens/gender_selection_page.dart';
import 'forgot_password.dart';
import 'registration.dart';

bool isPressed = true;

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Image.asset('assets/logo.png'),
            SizedBox(
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
            Reusable_TextField("Email", Icons.email_outlined, null),
            Reusable_TextField(
                "Password", Icons.lock_outline, Icons.visibility_off_outlined),
            Container(),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ForgotPassword(),
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
                      //recognizer: TapGestureRecognizer()..onTap = widget.onClickedRegister,
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
                //
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GenderSelections(),
                ));
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
                Text("Don't have an account?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );
                  },
                  child: Text(" Signup",
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

  Container Reusable_TextField(
      String hint_text, IconData icons, IconData? suffixicon) {
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
                    primary: Color(0xff2E2E2E40), secondary: Colors.white),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: secondbackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        icons,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPressed = !isPressed;
                            });
                          },
                          icon: (suffixicon != null)
                              ? (isPressed)
                                  ? Icon(
                                      Icons.visibility_off_outlined,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.grey,
                                    )
                              : Icon(null)),
                      prefixIconColor: Color(0xff2E2E2E40),
                      iconColor: const Color(0xff2E2E2E40),
                      hintText: hint_text,
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
                    style: textTheme.headline2
                        ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                    keyboardType: TextInputType.text,
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
