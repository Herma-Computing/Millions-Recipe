import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../models/ingredition.dart';

class ingedients extends StatelessWidget {
  const ingedients({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount:ingredientsItems.length,
              itemBuilder: (context,index){
               return ListTile(
                leading: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(boxShadow: [kBoxShadow], borderRadius: BorderRadius.circular(5), image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(ingredientsItems[index].image)) ),),
                title: Text(ingredientsItems[index].name,),
                subtitle: Text(ingredientsItems[index].weight),
                trailing: Text(ingredientsItems[index].place ,style: TextStyle(color:ingredientsItems[index].status==1?kPrimaryColor:Colors.black ),),
               );
            }),
          ),
                   
        ],
      ));
  }
}


