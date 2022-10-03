class Recipe {

  String title;
  String description;
  String image;
  int calories;
  int carbo;
  int protein;

  Recipe(this.title, this.description, this.image, this.calories, this.carbo, this.protein);

}

// class Meal {
//   final String strMeal;
//   final String strMealThumb;

//   Meal(this.strMeal, this.strMealThumb);

//   Meal.fromJson(Map<String, dynamic> json)
//       : strMeal = json['strMeal'],
//         strMealThumb = json['strMealThumb'];

//   Map<String, dynamic> toJson() => {
//         'name': strMeal,
//         'description': strMealThumb,
//       };
// }

List<Recipe> getRecipes(){
  return <Recipe>[
    Recipe("Chicken Fried Rice", "So irresistibly delicious", "https://hips.hearstapps.com/hmg-prod/images/chicken-fried-rice-vertical-1545488815.png", 250, 35, 6),
    Recipe("Pasta Bolognese", "True Italian classic with a meaty, chilli sauce", "https://st4.depositphotos.com/19157714/22934/i/1600/depositphotos_229347416-stock-photo-fresh-delicious-spagetti-bolognes.jpg", 200, 45, 10),
    Recipe("Garlic Potatoes", "Crispy Garlic Roasted Potatoes", "https://pngimg.com/uploads/steak/steak_PNG25.png", 150, 30, 8),
    Recipe("Asparagus", "White Onion, Fennel, and watercress Salad", "https://static.toiimg.com/thumb/55853250.cms?imgsize=394583&width=509&height=340", 190, 35, 12),
    Recipe("Filet Mignon", "Bacon-Wrapped Filet Mignon", "https://thefoodmedic.co.uk/wp-content/uploads/2022/03/IMG_0026-1140x760.jpg", 250, 55, 20),
  ];
}