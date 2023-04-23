import 'package:flutter/material.dart';

class name extends StatelessWidget {
  const name({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text('Home Page',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
      ],
    ));
  }
}
