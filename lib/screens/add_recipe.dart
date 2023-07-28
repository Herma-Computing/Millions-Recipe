// ignore_for_file: sized_box_for_whitespace

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../newhome.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  bool showCookingTime = false;
  bool showServing = false;
  bool showHidden = false;
  List<Ingredient> ingredients = [];
  List selectedImages = [];
  File? selectedImage;
  List<String> cookingSteps = [];
  List<File?> stepImages = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TextEditingController prepTime = TextEditingController();
  TextEditingController cookTime = TextEditingController();
  TextEditingController additionalTime = TextEditingController();
  TextEditingController refrigTime = TextEditingController();
  TextEditingController totalTime = TextEditingController();
  TextEditingController servingController = TextEditingController();

  void selectFile({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      setState(() {
        selectedImage = File(file!.path);
        selectedImages.add(selectedImage);
      });
    }
  }

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void addCookingStep() {
    setState(() {
      cookingSteps.add('');
      stepImages.add(null);
    });
  }

  void removeLastCookingStep() {
    if (cookingSteps.isNotEmpty) {
      setState(() {
        cookingSteps.removeLast();
        stepImages.removeLast();
      });
    }
  }

  void selectStepImage(int index) async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (file?.path != null) {
      setState(() {
        stepImages[index] = File(file!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Create a masterpiece',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () => selectFile(source: ImageSource.gallery),
                child: selectedImages.isNotEmpty
                    ? Container(
                        width: 336,
                        height: 203,
                        child: Stack(
                          children: [
                            PageView.builder(
                              itemCount: selectedImages.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Image.file(selectedImages[index]),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                          "${index + 1}/${selectedImages.length}"),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: 336,
                        height: 203,
                        color: Colors.grey,
                        child: const Center(
                          child: Text("Choose a Picture for the Meal"),
                        ),
                      ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () => selectFile(source: ImageSource.gallery),
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 30),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                    hintText: "Name of The Meal",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 27),
                child: SizedBox(
                  child: TextFormField(
                    controller: descriptionController,
                    maxLines: 15,
                    minLines: 5,
                    autocorrect: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 2.0,
                        ),
                      ),
                      hintText: "Description of the Meal",
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(83, 232, 139, 0.10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: Container(
                        height: 33,
                        width: 33,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: const Icon(Icons.group_outlined,
                            color: Colors.green),
                      ),
                    ),
                    const Text(
                      "Serving",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Text(
                      servingController.text,
                      style: const TextStyle(fontSize: 14),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showServing = !showServing;
                        });
                      },
                      icon: Icon(showServing
                          ? Icons.arrow_downward
                          : Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: showServing,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Serving",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: servingController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "0",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                            child: Text(
                          "Servings",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(83, 232, 139, 0.10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: Container(
                        height: 33,
                        width: 33,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: const Icon(Icons.access_time_outlined,
                            color: Colors.green),
                      ),
                    ),
                    const Text(
                      "Cooking Time",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showCookingTime = !showCookingTime;
                        });
                      },
                      icon: Icon(showCookingTime
                          ? Icons.arrow_downward
                          : Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              cookingTime("Prep Time", prepTime),
              cookingTime("Cooking Time", cookTime),
              cookingTime("Refrigerate Time (optional) ", refrigTime),
              cookingTime("Additional Time (optional) ", additionalTime),
              cookingTime("Total Time", totalTime),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(83, 232, 139, 0.10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: Container(
                        height: 33,
                        width: 33,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: const Icon(Icons.list, color: Colors.green),
                      ),
                    ),
                    const Text(
                      "Cooking Steps",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    const Text(
                      "",
                      style: TextStyle(fontSize: 14),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showHidden = !showHidden;
                        });
                      },
                      icon: showHidden
                          ? const Icon(Icons.arrow_downward)
                          : const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Visibility(
                visible: showHidden,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < cookingSteps.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 27, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Step ${i + 1}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                IconButton(
                                  onPressed: () => selectStepImage(i),
                                  icon: const Icon(Icons.add_a_photo),
                                ),
                              ],
                            ),
                            SizedBox(
                              child: TextFormField(
                                maxLines: 15,
                                minLines: 3,
                                autocorrect: true,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.green,
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(),
                                  ),
                                  hintText: "Steps for the meal",
                                ),
                                onChanged: (value) {
                                  cookingSteps[i] = value;
                                },
                              ),
                            ),
                            if (i == cookingSteps.length - 1)
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: removeLastCookingStep,
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                              ),
                          ],
                        ),
                      ),
                    GestureDetector(
                      onTap: addCookingStep,
                      child: Container(
                        width: 90,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.add),
                            Text(
                              "ADD STEP",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ingredients",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 55),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ingredients.isEmpty ? 1 : ingredients.length,
                  itemBuilder: (context, index) {
                    if (ingredients.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 142,
                              height: 44,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Item",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    ingredients.add(
                                        Ingredient(item: value, quantity: ''));
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            Container(
                              width: 142,
                              height: 44,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Quantity",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    ingredients[0].quantity = value;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 1),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 142,
                              height: 44,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Item",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    ingredients[index].item = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            Container(
                              width: 142,
                              height: 44,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Quantity",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    ingredients[index].quantity = value;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 1),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    ingredients.removeAt(index);
                                  });
                                },
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28, bottom: 35),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      ingredients.add(Ingredient(item: '', quantity: ''));
                    });
                  },
                  child:  Row(
                    children: const [
                      Icon(Icons.add),
                      Text(
                        "Add new ingredient",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (nameController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      (prepTime.text.isEmpty ||
                          totalTime.text.isEmpty ||
                          cookTime.text.isEmpty)) {
                    showToast("Please fill in all the required fields.");
                    return;
                  } else if (nameController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      (prepTime.text.isNotEmpty ||
                          totalTime.text.isNotEmpty ||
                          cookTime.text.isNotEmpty)) {
                    int recipeId = await SqlHelper.createRecipes(
                        nameController.text,
                        descriptionController.text,
                        prepTime.text,
                        cookTime.text,
                        refrigTime.text,
                        additionalTime.text,
                        totalTime.text,
                        servingController.text,
                        "${servingController.text} Servings");

                    List<Map<String, String>> ingredientData = [];

                    for (Ingredient ingredient in ingredients) {
                      ingredientData.add({
                        'name': ingredient.item,
                        'quantity': ingredient.quantity,
                        'unit': "ml"
                      });
                    }

                    await SqlHelper.insertIngredient(recipeId, ingredientData);

                    final List imageUrls =
                        selectedImages.map((image) => image.path).toList();
                    await SqlHelper.insertRecipeImage(recipeId, imageUrls);

                    for (int i = 0; i < cookingSteps.length; i++) {
                      String step = cookingSteps[i];
                      String? imageUrl;
                      if (stepImages[i] != null) {
                        imageUrl = stepImages[i]!.path;
                      }
                      await SqlHelper.insertStep(
                          recipeId, step, imageUrl ?? '');
                    }

                    setState(() {
                      nameController.clear();
                      descriptionController.clear();
                      prepTime.clear();
                      cookTime.clear();
                      refrigTime.clear();
                      additionalTime.clear();
                      totalTime.clear();
                      servingController.clear();
                      ingredients.clear();

                      for (int i = 0; i < ingredients.length; i++) {
                        ingredients[i].nameController.clear();
                        ingredients[i].quantityController.clear();
                      }
                    });

                    showToast("Recipe saved successfully!");

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NewHome(),
                    ));
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: 206,
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color(0xff15BE77),
                        Color(0xff53E88B),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      "Save Recipe",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Visibility cookingTime(String time, TextEditingController controller) {
    return Visibility(
      visible: showCookingTime,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "0",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                  child: Text(
                "mins",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              )),
            ],
          ),
          const SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}

class Ingredient {
  String item;
  String quantity;
  TextEditingController nameController;
  TextEditingController quantityController;

  Ingredient({required this.item, required this.quantity})
      : nameController = TextEditingController(text: item),
        quantityController = TextEditingController(text: quantity);
}
