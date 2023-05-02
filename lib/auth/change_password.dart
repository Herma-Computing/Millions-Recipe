import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Create new Password",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          const Flexible(
            child: Text("We have sent sent a recovery OTP to your email",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
          ),
          const SizedBox(
            height: 52,
          ),
          const Text("OTP code",
              textAlign: TextAlign.start, style: TextStyle(color: Colors.grey)),
          Padding(
            padding: const EdgeInsets.only(bottom: 13),
            child: reusableTextField("OPT Code"),
          ),
          const Text("Password", style: TextStyle(color: Colors.grey)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: reusableTextField("Password"),
          ),
          const Text("Confirm Password", style: TextStyle(color: Colors.grey)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: reusableTextField("Password"),
          ),
          const SizedBox(
            height: 7,
          ),
          GestureDetector(
            onTap: () {
              // todo:
              //
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
                  "Submit",
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
    );
  }

  Container reusableTextField(String hintText) {
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
                    primary: const Color(0xff2E2E2E),
                    secondary: Colors.white),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: secondbackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
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
