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
              itemCount:ingredients_items.length,
              itemBuilder: (context,index){
               return ListTile(
                leading: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(boxShadow: [kBoxShadow], borderRadius: BorderRadius.circular(5), image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(ingredients_items[index].image)) ),),
                title: Text(ingredients_items[index].name,),
                subtitle: Text(ingredients_items[index].weight),
                trailing: Text(ingredients_items[index].place ,style: TextStyle(color:ingredients_items[index].status==1?kPrimaryColor:Colors.black ),),
               );
            }),
          ),
                    Center(
                    child: GestureDetector(
                      child: Container(
                        width: 250,
                        height: 50,
                        decoration:BoxDecoration(
                          color: kPrimaryColor,
                           borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text("Show cooking steps",style: TextStyle(color: Colors.white),),)),
                    ),
                  )
        ],
      ));
  }
}


