import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:millions_recipe/home.dart';
import 'package:millions_recipe/screens/onboardingScreen.dart';
import 'package:millions_recipe/widgets/triangle_painter.dart';

class GenderSelections extends StatefulWidget {
  const GenderSelections({
    super.key,
  });
  @override
  State<GenderSelections> createState() => _GenderSelectionsState();
}

class _GenderSelectionsState extends State<GenderSelections> {
  double ageValue = 18.0;
  double heightValue = 170.0;
  double weightVlue = 170.0;
  String selectedHeight = "cm";
  String selectedWeight = "kg";
  RulerPickerController? heightPickerController;
  RulerPickerController? weightPickerController;
  final double _ruleScaleInterval = 10;

  int currentHeightValue = 30;
  int currentWeightValue = 30;
  List<DropdownMenuItem<String>> dropdownHeightItems = [
    const DropdownMenuItem(
        child: Text(
          "cm",
        ),
        value: "cm"),
    const DropdownMenuItem(child: Text("mm"), value: "mm"),
  ];
  List<DropdownMenuItem<String>> dropdownWeightItems = [
    const DropdownMenuItem(child: Text("kg"), value: "kg"),
    const DropdownMenuItem(child: Text("gram"), value: "gram"),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    heightPickerController = RulerPickerController(value: 0);
    weightPickerController = RulerPickerController(value: 0);
  }

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
                        backgroundColor: const Color.fromARGB(255, 224, 250, 225),
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
                  padding: const EdgeInsets.all(10.0),
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
                  padding: const EdgeInsets.only(right: 120),
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
                      padding: const EdgeInsets.only(left: 11, right: 10),
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
                        value: selectedHeight,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedHeight = newValue!;
                          });
                        },
                        items: dropdownHeightItems)
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                RulerPicker(
                  controller: heightPickerController!,
                  beginValue: 30,
                  endValue: 195,
                  initValue: currentHeightValue,
                  scaleLineStyleList: const [
                    ScaleLineStyle(
                        color: Colors.grey, width: 1.5, height: 30, scale: 0),
                    ScaleLineStyle(
                        color: Colors.grey, width: 1, height: 25, scale: 5),
                    ScaleLineStyle(
                        color: Colors.grey, width: 1, height: 15, scale: -1)
                  ],
                  onValueChange: (value) {
                    setState(() {
                      currentHeightValue = value;
                    });
                  },
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  rulerMarginTop: 8,
                  marker: Container(
                    child: SizedBox(
                      width: _ruleScaleInterval * 2,
                      height: 45,
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                width: 15,
                                height: 15,
                                child: CustomPaint(
                                  painter: TrianglePainter(),
                                ),
                              )),
                          Align(
                              child: Container(
                            width: 3,
                            height: 34,
                            color: HexColor("#53E88B"),
                          )),
                        ],
                      ),
                    ),
                  ),
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
                          value: selectedWeight,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedWeight = newValue!;
                            });
                          },
                          items: dropdownWeightItems)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RulerPicker(
                  controller: weightPickerController!,
                  beginValue: 50,
                  endValue: 195,
                  initValue: currentWeightValue,
                  scaleLineStyleList: const [
                    ScaleLineStyle(
                        color: Colors.grey, width: 1.5, height: 30, scale: 0),
                    ScaleLineStyle(
                        color: Colors.grey, width: 1, height: 25, scale: 5),
                    ScaleLineStyle(
                        color: Colors.grey, width: 1, height: 15, scale: -1)
                  ],
                  onValueChange: (value) {
                    setState(() {
                      currentWeightValue = value;
                    });
                  },
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  rulerMarginTop: 8,
                  marker: Container(
                    child: SizedBox(
                      width: _ruleScaleInterval * 2,
                      height: 45,
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                width: 15,
                                height: 15,
                                child: CustomPaint(
                                  painter: TrianglePainter(),
                                ),
                              )),
                          Align(
                              child: Container(
                            width: 3,
                            height: 34,
                            color: HexColor("#53E88B"),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // route to page when this button pressed
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const Home();
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
