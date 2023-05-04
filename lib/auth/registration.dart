import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:millions_recipe/api_service/api_provider.dart';
import 'login.dart';
import 'otp_verification.dart';

bool isPressed = true;
bool others = false;
bool passwd = true;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool checked = false;

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
            Reusable_TextField(
              "First Name",
              Icons.person_outline,
              null,
              others,
              firstnameController,
              TextInputType.text,
            ),
            Reusable_TextField(
              "Last Name",
              Icons.person_outline,
              null,
              others,
              lastnameController,
              TextInputType.text,
            ),
            Reusable_TextField(
              "Email",
              Icons.email_outlined,
              null,
              others,
              emailController,
              TextInputType.emailAddress,
            ),
            Reusable_TextField(
              "Password",
              Icons.lock_outline,
              Icons.visibility_off_outlined,
              passwd,
              passwordController,
              TextInputType.text,
            ),
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
                register();
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
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
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

  Future register() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    String res = await ApiProvider().registerUser(
        emailController.text,
        firstnameController.text,
        lastnameController.text,
        passwordController.text,
        'email_password');

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
        builder: (context) => const Otp(),
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
    bool hide,
    TextEditingController controller,
    TextInputType keybordtype,
  ) {
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
                    primary: const Color(0xff2E2E2E40),
                    secondary: Colors.white),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: secondbackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: controller,
                  obscureText: hide,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      icons,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPressed = !isPressed;
                            passwd = !passwd;
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
                  validator: (value) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
