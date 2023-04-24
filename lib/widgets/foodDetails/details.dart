import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:millions_recipe/models/ingredition.dart';
import '../../models/recipe_model.dart';
import '../../common/constants.dart';
import 'Diet/diet.dart';
import 'ingredients_page/ingredientpage.dart';
import 'nutration/nutration.dart';

   class foodDetails extends StatefulWidget {
    final Recipe meal;
  const foodDetails({super.key, required this.meal});

  @override
  State<foodDetails> createState() => _foodDetailsState();
}

class _foodDetailsState extends State<foodDetails> {
  final PageController _pageController=PageController();
      
   
var pageviewSelected = 0;
 final  List <Widget> Pages =[
  ingedients(),
  nutration(),
  Diet()
 ];

     
    
  @override
  Widget build(BuildContext context) {
   
  Color black=Color.fromARGB(115, 46, 46, 46);
  Color green=kPrimaryColor;
  Color red=Color(0xffE23E3E);
  Color white=Color(0xFFFFFFFF);
    return Scaffold(

      body: Container(
        width: double.infinity,
        child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
        Container(
         child: Padding(
           padding: const EdgeInsets.only(left: 15,right: 15,top: 40),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
             iconButton(white, black,Icons.arrow_back,()=>{
               Navigator.pop(context) }),
               
               iconButton(white, black,Icons.favorite_border_outlined,()=>{
              })
           ]),
         ),
         width: double.infinity,
         height: 250,
         decoration:BoxDecoration(
           image: DecorationImage(fit:BoxFit.cover, image: NetworkImage(widget.meal.images [0].url) )),)
               
        ,Container(
         
         child: Padding(
           padding: const EdgeInsets.only(left:16.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
      
             children: [
               Padding(
                 padding: const EdgeInsets.only(left:8.0,top: 21),
                 child: Text(widget.meal.name,style:GoogleFonts.poppins(
                   fontSize: 21,),)
               ),
               Row(
                children: [
                 Column(
                  children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical:6.0),
                   child: methdOfmenu( false,black,Icons.group_outlined,()=>{},"2 people"),
                 ),
                  Padding(
                     padding: const EdgeInsets.symmetric(vertical:6.0),
                    child: methdOfmenu(false,black,Icons.access_time_outlined ,()=>{},"10-15 mins"),
                  ),
                 ],
                 ),
         
                  Padding(
                   padding: const EdgeInsets.only(left:30.0),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
      
                      Padding(
                       padding: const EdgeInsets.symmetric(vertical:6.0),
                        child: methdOfmenu(false,black,Icons.egg_outlined,()=>{},widget.meal.nutritions[0].value+' '+widget.meal.nutritions[0].unit),
                      ),
                      Padding(
                         padding: const EdgeInsets.symmetric(vertical:6.0),
                        child: methdOfmenu(true,green,Icons.check_box ,()=>{},"You have all the ingredients"),
                      ),
                   ],),
                 )
         
               ],),
         
              
                
         
             ],
           ),
         ),
        ),
      
           Padding(
        padding: EdgeInsets.only(left: 16,right: 16,top: 16),
              
                child:Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [

                 Expanded(child: pageViewTextButton( 0, "Ingredients",true,green,(){
                 _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                   }),
                   ),

                 Expanded( child: pageViewTextButton( 1,"Nutrition",false ,green,(){
                     _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                     })),
                 
                 
                 Expanded(child: pageViewTextButton(2,"Diet",false,green,(){
                   _pageController.animateToPage(3, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                   })),
       
                ],) ,
                ),

                Expanded(
                  child: PageView(
                     onPageChanged: (int index){
                    setState(() {
                         pageviewSelected=index;
                         });
                      
                     },
                     controller: _pageController,
                     children:Pages,
                   ),
                ),
                
               
          ],
           
           
      
        ),
      ),
    );
  }

  GestureDetector pageViewTextButton(int index, String title , bool isSelected,  Color green, GestureTapCallback function) {
  
   return GestureDetector(
                onTap: function,
                child: Column(
                  children: [
                    Text(title,style: GoogleFonts.poppins(color: pageviewSelected==index?green:Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: 100,
                    height: 3,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: pageviewSelected==index?green:Colors.transparent),
                    )
                  ],
                ));
  }

  Row methdOfmenu(bool isSelected,Color color ,IconData icon,GestureTapCallback x,String title) {
    return Row(
              children: [ 
                GestureDetector(
                  onTap: x,
                  child: Icon(icon,color: isSelected ==true?color:Colors.black),
                ),Text(title,style: TextStyle(color: color),)
              ],
             );
  }



  Container iconButton(Color white, Color black,IconData icon,GestureTapCallback x) {
    return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(shape: BoxShape.circle, color: white),
          child: Center(child: IconButton(onPressed:x, icon: Icon(icon,color: Colors.black))));
  }

}










