import 'package:flutter/material.dart';

import '../../common/constants.dart';

class ChangePasswordClass extends StatefulWidget {
  const ChangePasswordClass({super.key});

  @override
  State<ChangePasswordClass> createState() => ChangePasswordState();
}

String? passwordError, confirmPasswordError;
bool _passwordVisible = false;
bool _confrimPasswordVisible = false;

class ChangePasswordState extends State<ChangePasswordClass> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  late FocusNode passwordFocusNode, confirmPasswordFocusNode;

  @override
  void initState() {
    _passwordVisible = false;
    _confrimPasswordVisible = false;
    super.initState();

    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    passwordFocusNode.addListener(() => setState(() {}));
    confirmPasswordFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  bool isSaved = false;

  final _formKey = GlobalKey<FormState>();
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
            title: const Text("Change Password",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ))),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40, left: 5, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [SizedBox(width: 35)],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25, bottom: 15),
                child: const Text(
                  "Create new password",
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: const Text(
                  "Your new password must be different from the old password",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  "Password",
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _container(
                        context,
                        passwordController,
                        "Password",
                        "password",
                        passwordFocusNode,
                        confirmPasswordFocusNode,
                        null, () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    }),
                    // passwordError != null && isSaved ? errorMessage(passwordError.toString()) : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                        "Confirm Password",
                      ),
                    ),
                    _container(
                        context,
                        confirmPasswordController,
                        "Confirm Password",
                        "confirm",
                        confirmPasswordFocusNode,
                        null,
                        passwordController.text, () {
                      setState(() {
                        _confrimPasswordVisible = !_confrimPasswordVisible;
                      });
                    }),
                    // confirmPasswordError != null && isSaved ? errorMessage(confirmPasswordError.toString()) : Container(),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  //TODO
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
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "Reset Password",
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
        ));
  }
}

Widget _container(
    BuildContext context,
    TextEditingController controller,
    String? hint,
    String? type,
    FocusNode focus,
    FocusNode? focusNext,
    String? confirmPassword,
    VoidCallback onTap) {
  TextTheme textTheme = Theme.of(context).textTheme;

  return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: const Color(0xffD9D9D9))),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextFormField(
          focusNode: focus,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          obscureText:
              type == "password" ? !_passwordVisible : !_confrimPasswordVisible,
          style: textTheme.displayMedium
              ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
          textAlignVertical: TextAlignVertical.center,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            filled: true,
            // fillColor: Colors.grey,
            // Theme.of(context).colorScheme.primaryContainer,
            hintStyle: TextStyle(color: Colors.grey[400]),
            hintText: hint,
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15.0),
            ),
            errorStyle: const TextStyle(fontSize: 0.01),
            contentPadding:
                const EdgeInsets.only(left: 25, top: 10, bottom: 10),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(15.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15.0),
            ),
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: onTap,
              icon: Icon(
                  type == "password"
                      ? _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off
                      : _confrimPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                  color: Theme.of(context).colorScheme.onPrimary), //
            ),
          ),
          onFieldSubmitted: ((value) {
            if (type == "password") {
              FocusScope.of(context).requestFocus(focusNext);
            } else {
              FocusScope.of(context).unfocus();
            }
          }),
          validator: ((value) {
            if (type == "password") {
              if (value != null && value.length < 8) {
                passwordError = "Must be at least 8 characters";
                return passwordError;
              } else {
                passwordError = null;
                return null;
              }
            } else if (type == "confirm") {
              if (value != confirmPassword) {
                confirmPasswordError = "Both passwords must match";
                return confirmPasswordError;
              } else {
                confirmPasswordError = null;
                return null;
              }
            } else {
              return null;
            }
          }),
        ),
      ));
}
