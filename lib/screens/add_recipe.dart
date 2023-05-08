import 'package:flutter/material.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({
    super.key,
  });
  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: const Center(child: Text('Add Recipe Screen')),
    );
  }
}
