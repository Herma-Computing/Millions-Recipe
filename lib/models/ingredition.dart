class Items {
  String image;
  String name;
  String weight;
  String place;
  int status;
  Items(this.image, this.name, this.weight, this.place,this.status);
    }

   List <Items> ingredients_items=[
   Items("https://media.istockphoto.com/id/1388403435/photo/fresh-carrots-isolated-on-white-background.jpg?b=1&s=170667a&w=0&k=20&c=PJAHETwd9svcjPbrmnmnEmLsTFHLmxjpLpFfKiRzm-4=",
   "Carrot", "250 mg", "In your fridge",1),
   Items("https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGFwcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60", 
   "Apple", "250 mg", "In your fridge",1),
   Items("https://static01.nyt.com/images/2016/03/03/world/00WIT_CHINA-CHEESE/00WIT_CHINA-CHEESE-jumbo-v6.jpg?quality=75&auto=webp",
    "Cheese", "250 mg", "Not in your fridge",0),
   Items("https://i.pinimg.com/564x/db/f0/04/dbf004bfe8522da759eaf94190290aa3.jpg", 
    "Strawberry", "250 mg", "In your fridge",1)
];
