import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:millions_recipe/home.dart';
import 'package:millions_recipe/screens/onboardingScreen.dart';

class GenderSelections extends StatefulWidget {
  @override
  State<GenderSelections> createState() => _GenderSelectionsState();
}

class _GenderSelectionsState extends State<GenderSelections> {
  double ageValue = 18.0;
  double heightValue = 170.0;
  double weightVlue = 170.0;
  String selectedHeightValue = "cm";
  String selectedWeightValue = "kg";
  List<DropdownMenuItem<String>> dropdownHeightItems = [
    const DropdownMenuItem(
        child: Text(
          "cm",
        ),
        value: "cm"),
    DropdownMenuItem(child: Text("mm"), value: "mm"),
  ];
  List<DropdownMenuItem<String>> dropdownWeightItems = [
    DropdownMenuItem(child: Text("kg"), value: "kg"),
    DropdownMenuItem(child: Text("gram"), value: "gram"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color.fromARGB(255, 224, 250, 225),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext cxontext) {
                                return Onbording();
                              }));
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: HexColor("#53E88B"),
                              size: 24,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 20),
                            child: Text(
                              "Help us get you ",
                              style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              " your dream body",
                              style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "get mails accourated for your needs",
                    style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                          color: HexColor("#2E2E2E80"),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 120),
                  child: Text(
                    "Choose your gender",
                    style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      'assets/allSVG/girl.svg',
                      width: 160.0,
                      height: 160.0,
                    ),
                    SvgPicture.asset(
                      'assets/allSVG/boy.svg',
                      width: 160.0,
                      height: 160.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: SvgPicture.asset(
                        'assets/allSVG/ageIcon.svg',
                        width: 22.0,
                        height: 22.0,
                      ),
                    ),
                    Text(
                      "Age",
                      style: GoogleFonts.manrope(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
                HorizontalPicker(
                  minValue: 18,
                  maxValue: 150,
                  divisions: 132,
                  backgroundColor: Colors.white,
                  showCursor: false,
                  activeItemTextColor: HexColor("#53E88B"),
                  passiveItemsTextColor: Colors.black38,
                  onChanged: (value) {
                    setState(() {
                      ageValue = value;
                    });
                  },
                  height: 100,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SvgPicture.asset(
                        'assets/allSVG/heightIcon.svg',
                        width: 27.0,
                        height: 27.0,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Height",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ),
                    DropdownButton(
                        underline: Container(),
                        value: selectedHeightValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedHeightValue = newValue!;
                          });
                        },
                        items: dropdownHeightItems)
                  ],
                ),
                //Height section
                HorizontalPicker(
                  minValue: 170,
                  maxValue: 195,
                  divisions: 50,
                  backgroundColor: Colors.white,
                  showCursor: true,
                  cursorColor: Color.fromARGB(255, 131, 255, 135),
                  activeItemTextColor: HexColor("#53E88B"),
                  passiveItemsTextColor: Colors.black38,
                  onChanged: (value) {
                    setState(() {
                      heightValue = value;
                    });
                  },
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SvgPicture.asset(
                          'assets/allSVG/weightIcon.svg',
                          width: 22.0,
                          height: 22.0,
                        ),
                      ), //
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Weight",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ),
                      DropdownButton(
                          underline: Container(),
                          value: selectedWeightValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedWeightValue = newValue!;
                            });
                          },
                          items: dropdownWeightItems)
                    ],
                  ),
                ),
                HorizontalPicker(
                  minValue: 170,
                  maxValue: 195,
                  divisions: 50,
                  backgroundColor: Colors.white,
                  initialPosition: InitialPosition.center,
                  showCursor: true,
                  cursorColor: Color.fromARGB(255, 131, 255, 135),
                  activeItemTextColor: HexColor("#53E88B"),
                  passiveItemsTextColor: Colors.black38,
                  onChanged: (value) {
                    weightVlue = value;
                  },
                  height: 100,
                ),
                InkWell(
                  onTap: () {
                    // route to page when this button pressed
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Home();
                    }));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(60),
                    width: 208.47,
                    height: 44,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Color(0xff15BE77),
                            Color(0xff53E88B),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
