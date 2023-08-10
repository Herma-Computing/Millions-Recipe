import 'package:flutter/material.dart';

class MyNutration extends StatelessWidget {
  // final Recipe meal;
  const MyNutration({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const ListTile(
                leading: Text("nutritions"),
                trailing: Text("value"),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 1,
                color: const Color.fromARGB(48, 85, 84, 84),
              )
            ],
          );
        });
  }
}
