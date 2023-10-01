import 'package:flutter/material.dart';

class AuthFirst extends StatefulWidget {
  const AuthFirst({super.key});

  @override
  State<AuthFirst> createState() => _AuthFirstState();
}

class _AuthFirstState extends State<AuthFirst> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.55,
                child: Image.asset("assets/auth_first.jpg")),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Text(
                'You must Login/Sign up to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(top: 22),
                width: 132,
                height: 50,
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
                    "Log in / Sign up",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
