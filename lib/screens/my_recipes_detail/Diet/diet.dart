import 'package:flutter/material.dart';

class MyDiet extends StatelessWidget {
  const MyDiet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, rowIndex) {
            // final startIndex = rowIndex * 3;
            // final endIndex = startIndex + 3;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                    child: container("vegan") // Replace with your own widget
                    ),
              ],
            );
          },
        ));
  }

  Container container(String title) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
          border: Border.all(
            color: Colors.grey,
            width: 2.0,
          )),
      child: Center(
          child: Text(
        textAlign: TextAlign.center,
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      )),
    );
  }
}
