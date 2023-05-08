import 'package:flutter/material.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({
    super.key,
  });
  @override
  State<RecipesPage> createState() => _RecipesState();
}

class _RecipesState extends State<RecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecipesPage'),
      ),
      body: const Center(child: Text('RecipesPage Screen')),
    );
  }
}
