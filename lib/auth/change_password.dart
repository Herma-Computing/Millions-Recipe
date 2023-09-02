import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

import '../api_service/api_provider.dart';
import 'login.dart';

class ChangePassword extends StatefulWidget {
  final String email;
  const ChangePassword({super.key, required this.email});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String? passwordError;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Create new Password",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              const Text("We have sent sent a recovery OTP to your email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey)),
              const SizedBox(
                height: 52,
              ),
              const Text("OTP code",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey)),
              Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: reusableTextField("OPT Code", codeController),
              ),
              const Text("Password", style: TextStyle(color: Colors.grey)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: reusableTextField("Password", passwordController),
              ),
              const Text("Confirm Password",
                  style: TextStyle(color: Colors.grey)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: reusableTextField("Confirm Password", confirmController),
              ),
              const SizedBox(
                height: 7,
              ),
              GestureDetector(
                onTap: () {
                  // todo:
                  newPassword();
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
        ),
      ),
    );
  }

  Future newPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            ));

    try {
      String res = await ApiProvider().setNewPassword(
        widget.email,
        passwordController.text,
        int.parse(codeController.text),
      );

      if (res == "success") {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const LogIn(),
        ));
      } else {
        // ignore: use_build_context_synchronously
        Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
          titleSize: 20,
          messageSize: 17,
          backgroundColor: Colors.green,
          borderRadius: BorderRadius.circular(8),
          message: res,
          duration: const Duration(seconds: 5),
        ).show(context);
      }
    } catch (e) {
      //
    }
  }

  Container reusableTextField(
    String hintText,
    TextEditingController controller,
  ) {
    Color secondbackgroundColor = Theme.of(context).cardColor;
    final inputBorder = OutlineInputBorder(
        // borderSide: Divider.createBorderSide(context),
        borderSide: BorderSide(
        color: Theme.of(context).colorScheme.secondary,
        width: 0.7,
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
                    // ignore: use_full_hex_values_for_flutter_colors
                    primary: const Color(0xFF2E2E2E40),
                    secondary: Colors.white),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: secondbackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: controller,
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
                  style: textTheme.displayMedium
                      ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
