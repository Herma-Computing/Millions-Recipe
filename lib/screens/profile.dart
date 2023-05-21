import 'package:flutter/material.dart';
import 'package:millions_recipe/reciep_icons.dart';

import '../common/constants.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(top: 35, left: 25, right: 25),
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profileHeader(),
            accountCard(),
            theamCard(),
            profileOtherCard() 
          ],
              ),
            ),
        ));
  }

  Card accountCard() => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Padding(
                padding: EdgeInsets.only(left:20.0),
                child: Text(
                  'Account',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            ListTile(
              dense: true,
              leading: Icon(ReciepIcons.cil_fridge),
              title: Text('My Fridge'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              dense: true,
              leading: Icon(ReciepIcons.health),
              title: Text('My Health'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              dense: true,
              leading: Icon(ReciepIcons.list),
              title: Text('My Meal Planner'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              dense: true,
              leading: Icon(ReciepIcons.goal),
              title: Text('My Goals'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      );


      Card theamCard() => Card(
        margin: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Padding(
                padding: EdgeInsets.only(left:20.0),
                child: Text(
                  'Theam',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            ListTile(
              dense: true,
              leading: const Icon(ReciepIcons.ph_sun_dim),
              title: const Text('Light Mode'),
              trailing: Icon( Icons.toggle_off_outlined, color: kActiveColor,size: 32,),
            ),
            
          ],
        ),
      );

 Card profileOtherCard() => Card(
  margin: const EdgeInsets.only(top: 15),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Padding(
                padding: EdgeInsets.only(left:20.0),
                child: Text(
                  'Other',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            ListTile(
              dense: true,
              leading: Icon(ReciepIcons.chat),
              title: Text('Forum'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              dense: true,
              leading: Icon(ReciepIcons.setting),
              title: Text('Setting'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              dense: true,
              leading: Icon(ReciepIcons.ph_code),
              title: Text('Meet the Developer'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              dense: true,
              leading: Icon(ReciepIcons.share),
              title: Text('Invite Friends'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      );





  Widget profileHeader() => ListTile(
        leading: Container(
          width: 55,
          height: 55,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset('assets/Ellipse 7.png'),
        ),
        title: const Text(
          'Mohammed Ibrahim',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Manrope'),
        ),
        subtitle: const Text(
          'Junior Chef',
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 12, fontFamily: 'Manrope'),
        ),
        trailing: Container(
          //  margin: const EdgeInsets.only(top: 16),
          width: 87.5,
          height: 30.7,
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
              "Edit",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ),
      );
}
