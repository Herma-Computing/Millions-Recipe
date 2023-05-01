import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:millions_recipe/common/constants.dart';
import 'package:millions_recipe/providers/recipe_provider.dart';
import 'package:millions_recipe/screens/detail_screen.dart';
import 'package:millions_recipe/common/shared.dart';
import 'package:millions_recipe/widgets/Home/List_gatagory/upper_model.dart';
import 'package:provider/provider.dart';

import 'models/recipe_model.dart';
import 'widgets/foodDetails/details.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver{
  //new code
     int bottom_nav_index=0;
  bool _isFabEnabled = true;
   int selectedIndex=0;
   final tab_data = [
    "Breakfast",
    "Appetizers",
    "Dinner",
    "Lunch",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "three",
    "four",
    "five",
  ];
  TextEditingController _search_controller = TextEditingController();
  Color _card_green=Color.fromARGB(41, 103, 193, 196);
  Color black = Color.fromARGB(115, 46, 46, 46);
  Color green = Color(0xFF53E88B);
  Color border = Color(0xffD9D9D9);
  Color red = Color(0xffE23E3E);
  Color search=Color(0XffC1C1C1);
  Color white = Color(0xFFFFFFFF);
  Color left_liner_gradient_green=Color(0xff53E88B);
  Color right_liner_gradient_green=Color(0xff15BE77);



  List<bool> optionSelected = [false, false, false];
  String category = "Bread";
  List<String> catgories = [
    'Bread',
    'Breakfast and Brunch',
    'Appetizers and Snacks',
    'Main Dishes',
    'Meat and Poultry',
    'Everyday Cooking',
    'Desserts',
    'Fruits and Vegetables',
    'Side Dish',
    'Drink Recipes',
    'Pasta and Noodles,'
        'Salad',
    'Holidays and Events Recipes',
    'Seafood',
    'Soups, Stews and Chili Recipes',
  ];
  bool isCategorySelecting = false;

  bool isSearching = false;
  String searchQuery = "";
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  List<Recipe> result = [];
  ScrollController scrollController = ScrollController();
  ScrollController sController = ScrollController();
  bool loading = true;
  int offset = 0;
  int currentPage = 1;
  @override

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fetchData(offset, "");
    final recipeProvider = Provider.of<Recipes>(context, listen: false);
    recipeProvider.fetchRecipesByCategory("Main Dishes");
    handleNext();
  }

  @override
  void dispose() {
     WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    searchController.dispose();
    searchFocusNode.dispose();
  }
   
    void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom ??0;
    final isKeyboardVisible = bottomInset > 0;
    setState(() {
      _isFabEnabled = !isKeyboardVisible;
    });
  }

  void fetchData(paraOffset, String query) async {
    setState(() {
      loading = true;
    });

    if (isSearching || isCategorySelecting) {
      result.clear();
    }
    List<Recipe> recipeList = [];
    final recipeProvider = Provider.of<Recipes>(context, listen: false);
    await recipeProvider.getRecipeApis(
        currentPage.toString(), query, category, isSearching);
    recipeList = recipeProvider.recipeList;
    // response.data["recipes"].forEach(
    //     (el) async => {recipe = Recipe.fromJson(el), recipeList.add(recipe)});

    result = result + recipeList;
    int localOffset = offset + 15;
    if (!isSearching) {
      currentPage++;
    }
    setState(() {
      result;
      loading = false;
      offset = localOffset;
      isCategorySelecting = false;
    });
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        fetchData(offset, searchQuery);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<Recipes>(context);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
         padding: const EdgeInsets.only(left: 13.0, right: 13, top: 20),
        child: ListView(
          controller: scrollController,
          children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text("Hi,Mohammed"),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("Let`s make a masterprice"),)],),
                  Stack(
                    children: [
                      Icon(
                        Icons.notifications_outlined,size: 40,),
                      Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: green,
                                shape: BoxShape.circle,
                                border: Border.all(color: border, width: 1)),))], ) ],),


              //Search Bar 
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                padding: EdgeInsets.symmetric(horizontal: 8),
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: border, width: 1)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    iconMethod(Icons.search_outlined),
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      focusNode: searchFocusNode,
                      onChanged: ((value) => {
                              searchQuery = searchController.text,
                              fetchData(offset, searchQuery)
                            }),
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 16),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle:
                            GoogleFonts.poppins(color: search, fontSize: 16),
                        hintText: 'Search recipes',),)),iconMethod(Icons.menu),],),),
        
      
      
             text("Popular Category"),
                Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: SizedBox(
                    height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: tab_data.length,
                          itemBuilder: (context, index) {
                            return  GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectedIndex=index;
                                });},
                              child: index==selectedIndex? Container(
                                margin: EdgeInsets.symmetric(horizontal: 6),
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                 gradient: LinearGradient(
                                 colors: [
                                  left_liner_gradient_green,
                                  right_liner_gradient_green],
                            
                                 begin: Alignment.centerLeft,
                                 end: Alignment.centerRight,
                                 ),
                                borderRadius: BorderRadius.circular(8),color: green),
                                child:Center(child: Text(tab_data[index],style: GoogleFonts.poppins(fontSize: 15,color: white),)),)
                           :Padding(
                            padding: const EdgeInsets.all(8.0),
                              child: Center(
                              child: Text(
                              tab_data[index],
                              style:
                                      GoogleFonts.poppins(fontSize: 16, color: green),
                                ),),));})),),
      
             Container(
              height: 270,
              child: Consumer<Recipes>(
                builder: (context, fs, child) {
                  return Container(
                    child: recipeProvider.loading
                        ? const Center(
                            child: const CircularProgressIndicator(
                            strokeWidth: 4,)):
                       
                         ListView.builder(
                 scrollDirection: Axis.horizontal,
                 itemCount: food_model.length,
                 itemBuilder: (contetx,index){
                   return GestureDetector(
                     onTap: ()=>{
                        Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                    builder: (context) =>
                                  foodDetails(meal: recipeProvider.recipes[index])),)},

                     child: Stack(children: [
                       Container(
                        margin: EdgeInsets.only(right: 30,top: 60),
                        width: 170,height: 220,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: _card_green,),
                        child: Padding(
                          padding: EdgeInsets.only(top: 60,left:8,right: 8 ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                           Text(recipeProvider.recipes[index].name,textAlign:TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.manrope(fontSize: 14,fontWeight: FontWeight.w700),)       
                          , Text(recipeProvider.recipes[index].description ,maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize: 9,),),
                       Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text("Time",style: GoogleFonts.manrope()),
                          
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              Text("10 Mins",style: GoogleFonts.manrope(fontWeight: FontWeight.w700),)
                             , Container(
                              margin: EdgeInsets.only(right: 5,),
                              width: 35,height: 35,
                              decoration: BoxDecoration(
                                color:food_model[index].isfavorite==true? red: Colors.white,
                                shape: BoxShape.circle),
                                child: Center(
                                  child: Icon(Icons.favorite_border_outlined,size: 25,
                                  color: food_model[index].isfavorite==true?Colors.white:Colors.black)),)],)]),)]),),),
                       Positioned(
                        top: 15,
                        left: 36,
                        child: Container(
                        width: 100,height: 100, 
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 0),)],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                            recipeProvider.recipes[index].images.isNotEmpty
                             ?recipeProvider.recipes[index].images[0].url
                              : "https://cdn.dribbble.com/users/1013019/screenshots/3281397/media/9de100ad01c34ec34d35e843d33504f9.jpg?compress=1&resize=400x300",),),
                             shape: BoxShape.circle,)),)],),);}),);},),),
        
                Padding(
                 padding: const EdgeInsets.symmetric(vertical:20.0),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  text("Recent Recipes"),
                  GestureDetector(
                    onTap: ()=>{print("hello world")},
                    child: Row(children: [
                      Text("See all",style: GoogleFonts.manrope(color: green),),
                      Icon(Icons.arrow_forward,color: green,)
                    ],),)],),),

          

 //recent
            Consumer<Recipes>(builder: (context, value, child) {
              return  Container(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: result.length + 1,
                  controller: sController,
                  itemBuilder: (context,index){
                     if (index == result.length) {
                          return loading
                              ? Container(
                                  height: 200,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 4,),),): Container();}

                   return GestureDetector(
                    onTap: ()=>{
                     
                     Navigator.push(context, MaterialPageRoute(builder: (context){
                      return foodDetails(meal: recipeProvider.recipes[index]);
                     }))
                      },
                     child: Container(
                      margin: EdgeInsets.only(right: 12),
                       child: Column(
                        children: [
                          Container(
                            width: 150,
                            height: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(result[index].images.isNotEmpty
                                            ? result[index].images[0].url
                                            : "https://cdn.dribbble.com/users/1013019/screenshots/3281397/media/9de100ad01c34ec34d35e843d33504f9.jpg?compress=1&resize=400x300"))),),
                             Container(
                              width:140,
                              child: Text(result[index].name, 
                              maxLines: 2,overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start,))
                        ],),),);}),);})],), ),
//bottom navigation bar
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
           BottomNavItems("Home",Icons.home_outlined,0),
           BottomNavItems("My Recipes",Icons.card_travel_outlined,1),
           SizedBox(width: 50,),
           BottomNavItems("Favourites",Icons.favorite_border_outlined,2),
           BottomNavItems("Profile",Icons.person_outline_outlined,3)],),),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:_isFabEnabled? Container(
        margin: EdgeInsets.only(top:17),
        height: 90,width: 85,

      child: new FloatingActionButton(
              backgroundColor: Color.fromARGB(0, 255, 255, 255),
       child:  Center(
       child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Container(width: 60,height: 60,
               decoration: BoxDecoration(
               color: Colors.greenAccent,
               shape: BoxShape.circle),child:  Icon(Icons.add,),),
               Text("Add Recipe",style: GoogleFonts.manrope(color: Colors.black,fontSize: 12),)],),), elevation: 0.0,onPressed: () {},),):null);}

  Text text(String text) => Text(text,style: GoogleFonts.manrope(fontSize: 21, fontWeight: FontWeight.w800));

  Widget option(String text) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20),),boxShadow: [kBoxShadow],),
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              SizedBox(width: 8,),
              Text(text,style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold, ),),],),),),);}


  GestureDetector BottomNavItems(String label,IconData icon,index) {
    return GestureDetector(
          onTap: ()=>{},
           child: Container(
            height: 60,
             child: Center(
               child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(icon),
                Text(label,style: GoogleFonts.manrope(fontSize:12,),)],),),),);}


   IconButton iconMethod(IconData icon) => IconButton(
      onPressed: () {},
      icon: Icon(
        icon,
        size: 35,
        color: border,));}
