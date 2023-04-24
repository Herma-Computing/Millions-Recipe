import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:millions_recipe/screens/onboardingScreen.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

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
    DropdownMenuItem(child: Text("cm"), value: "cm"),
    DropdownMenuItem(child: Text("mm"), value: "mm"),
  ];
  List<DropdownMenuItem<String>> dropdownWeightItems = [
    DropdownMenuItem(child: Text("kg"), value: "kg"),
    DropdownMenuItem(child: Text("gram"), value: "gram"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext cxontext) {
                          return Onbording();
                        }));
                      },
                      icon: Icon(
                        Icons.arrow_circle_left,
                        color: Color.fromARGB(255, 156, 224, 158),
                        size: 40,
                      )),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text("Help us Get ",
                            style: TextStyle(
                                color: HexColor("#2E2E2E"),
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(" your Dream Body",
                          style: TextStyle(
                              color: HexColor("#2E2E2E"),
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("get mails accourated for your needs",
                    style: TextStyle(
                        color: HexColor("#2E2E2E"),
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(right: 80),
                child: Text("Choose Your Gender",
                    style: TextStyle(
                        color: HexColor("#2E2E2E"),
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
              GenderSelection(
                femaleImage: const NetworkImage(
                    "https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png"),
                maleImage: const NetworkImage(
                    "https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png"),
                selectedGenderIconBackgroundColor: Colors.amber,
                selectedGenderTextStyle: const TextStyle(
                  color: Colors.amber,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
                checkIconAlignment: Alignment.centerRight,
                selectedGenderCheckIcon: null,
                onChanged: (Gender gender) {
                  print(gender);
                },
                equallyAligned: true,
                animationDuration: const Duration(milliseconds: 400),
                isCircular: true,
                isSelectedGenderIconCircular: true,
                opacityOfGradient: 0.4,
                padding: const EdgeInsets.all(3),
                size: 120,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.person),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Age"),
                  ),
                ],
              ),
              SfSlider(
                min: 18.0,
                max: 25,
                value: ageValue,
                interval: 1,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  setState(() {
                    ageValue = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.height),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Height"),
                  ),
                  DropdownButton(
                      value: selectedHeightValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedHeightValue = newValue!;
                        });
                      },
                      items: dropdownHeightItems)
                ],
              ),
              SfSlider(
                min: 170.0,
                max: 195,
                value: heightValue,
                interval: 5,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  setState(() {
                    heightValue = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.width_normal),
                    ), //
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Weight"),
                    ),
                    DropdownButton(
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
              SfSlider(
                min: 170.0,
                max: 195,
                value: weightVlue,
                interval: 5,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  setState(() {
                    weightVlue = value;
                  });
                },
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
