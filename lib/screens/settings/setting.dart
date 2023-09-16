import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:millions_recipe/screens/settings/contact_us.dart';
import 'package:millions_recipe/screens/add_ingridents.dart';
import 'package:millions_recipe/screens/settings/terms_and_conditions.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../my_flutter_app_icons.dart';
import '../../providers/theme_provider.dart';
import 'change_password.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: kPrimaryColor.withOpacity(0.25),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          title: const Text(
            'Settings',
            style: TextStyle(
              // color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 35, left: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                accountCard(),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.only(top: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Notification',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          leading: const Icon(MyFlutterApp.notification_icon),
                          title: const Text("Pop-up Notification"),
                          trailing: CupertinoSwitch(
                            activeColor: Colors.white38,
                            thumbColor: Colors.green.shade900,
                            trackColor: Colors.black12,
                            value: themeChange.isDarkMode,
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                profileOtherCard()
              ],
            ),
          ),
        ));
  }

  Card accountCard() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
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
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChangePasswordClass(),
                  ));
                },
                dense: true,
                leading: const Icon(MyFlutterApp.password),
                title: const Text('Change Password'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const ListTile(
                dense: true,
                leading: Icon(MyFlutterApp.subway_world),
                title: Text('Language'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      );

  Card profileOtherCard() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.only(top: 15),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Help',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ContactUs(),
                  ));
                },
                dense: true,
                leading: const Icon(Icons.contact_phone_outlined),
                title: const Text('Contact Us'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingPage(),
                  ));
                },
                dense: true,
                leading: const Icon(Icons.wallet_travel_outlined),
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TermsAndConditions(),
                  ));
                },
                dense: true,
                leading: const Icon(Icons.content_paste_outlined),
                title: const Text('Terms and Services'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddIngredients(),
                    ),
                  );
                },
                dense: true,
                leading: const Icon(MyFlutterApp.question_mark),
                title: const Text("Million Recipe's FAQ"),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      );
}
