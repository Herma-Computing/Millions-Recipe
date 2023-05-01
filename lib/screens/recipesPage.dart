import 'package:flutter/material.dart';

class RecipesPage extends StatefulWidget {
  @override
  State<RecipesPage> createState() => _RecipesState();
}

class _RecipesState extends State<RecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RecipesPage'),
      ),
      body: Center(child: Text('RecipesPage Screen')),
    );
  }
}
