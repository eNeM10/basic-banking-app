import 'dart:async';
import 'package:flutter/material.dart';

import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/constants/data.dart';
import 'package:basic_banking_app/screens/landingScreen.dart';
import 'package:basic_banking_app/screens/loginScreen.dart';
import 'package:basic_banking_app/utils/Database.dart';
import 'package:basic_banking_app/widgets/JumpingDots.dart';


import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(milliseconds: 3000);
    return new Timer(duration, navigate);
  }

  void navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? login = prefs.getBool("login");
    if (login == null || login == false) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(
            prefs: prefs,
          ),
        ),
      );
    } else {
      DatabaseHelper.instance.getCustomerFromID(username);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LandingScreen(
            index: 0,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColorDark,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 7,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Logo.png',
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MyBank',
                        style: TextStyle(
                          color: kHeadTextColorDark,
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        'App',
                        style: TextStyle(
                          color: kPrimaryTextColorDark,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Manage all your expenses at one place',
                    style: TextStyle(
                      color: kPrimaryTextColorDark,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: JumpingDotsProgressIndicator(
                fontSize: 60.0,
                color: kPrimaryColorDark,
                milliseconds: 200,
                numberOfDots: 5,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Made by Nityasmit Mallick',
                style: TextStyle(color: kSecondaryTextColorDark),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
}
