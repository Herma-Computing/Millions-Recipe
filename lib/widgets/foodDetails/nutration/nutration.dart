import 'package:flutter/material.dart';


class nutration extends StatelessWidget {
  const nutration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(child: ListView.builder(itemBuilder: (context,index){
     return Column(
       children: [
         ListTile(
          leading: Text("Protein"),
          trailing: Text("27g"),
         ),
         Container(
          margin: EdgeInsets.symmetric(horizontal: 10
          ),
          width: double.infinity,
          height: 1,
           color: Color.fromARGB(48, 85, 84, 84),
         )
       ],
     );
    }
    
    ),);
  }
}










