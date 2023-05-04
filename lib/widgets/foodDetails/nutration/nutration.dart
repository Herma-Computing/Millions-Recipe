import 'package:flutter/material.dart';


class Nutrition extends StatelessWidget {
  const Nutrition({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(child: ListView.builder(itemBuilder: (context,index){
     return Column(
       children: [
         const ListTile(
          leading: Text("Protein"),
          trailing: Text("27g"),
         ),
         Container(
          margin: const EdgeInsets.symmetric(horizontal: 10
          ),
          width: double.infinity,
          height: 1,
           color: const Color.fromARGB(48, 85, 84, 84),
         )
       ],
     );
    }
    
    ),);
  }
}










