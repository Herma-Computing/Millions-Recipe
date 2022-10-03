import 'package:flutter/material.dart';
import './providers/recipe_provider.dart';
import 'package:provider/provider.dart';
import './models/meal_model.dart';
import './providers/meal_provider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {

  // List<Meal> meals = [];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
     final recipeModel = Provider.of<Recipes>(context, listen: false);
    recipeModel.fetchRecipes();
  }
 String searchText = '';
final TextEditingController _controller = TextEditingController();
 

  @override
  Widget build(BuildContext context) {
final recipeProvider = Provider.of<Recipes>(context);
print("recipe:");
// print(mealProvider.fetchedMeals());
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: Column(
          children: [
             Consumer<Meals>(
  builder: (context, meal, child) {
    // print(mealProvider.fetchedMeals());
 return  Container(child: recipeProvider.loading ? Text("loading...") :Column(
  children: [
    TextField(
controller: _controller,
onChanged: ((value) {
  // mealProvider.searchFetchedMeals(_controller.text);
  setState(() {
    searchText = _controller.text;
  });
}),
    ),
    
        Container(
          height: MediaQuery.of(context).size.height*0.8,
          color: Colors.red,
          child: SingleChildScrollView(
            child: Column(
                  children: recipeProvider.recipes
                      .map((recipe) => Container(
                        
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  // boxShadow: [kBoxShadow],
                                ),
                                margin: EdgeInsets.only(
                                    right: 16,
                                    // left: index == 0 ? 16 : 0,
                                    bottom: 16,
                                    top: 8),
                                padding: const EdgeInsets.all(16),
                                width: 220,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Container(
                                      child: Image.network(
                                          recipe.images[0].url),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(recipe.name),
                                    Text("recipe description"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('80' + " Kcal"),
                                        const Icon(
                                          Icons.favorite_border,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),)
                      .toList(),
                ),
          ),
        )
  ],
 ),);
  },
),
          ],
        ),
      ),
    );
  }
}