import 'package:flutter/material.dart';

class Diet extends StatelessWidget {
  const Diet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        container("Atkins"),
        container("Vegetarian"),
        container("Vegan"),],),

       Padding(
         padding: const EdgeInsets.only(top:20.0),
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          container("Atkins"),
          container("Vegetarian"),
          container("Vegan"),],),
       )

      ],
      ),
    );
  }

  Container container( String title) {
    return Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,border:Border.all(
      color: Colors.grey,
      width: 2.0,
    )),
        child: Center(child: Text(title)),);
  }
}
