import 'dart:async';

import 'package:flutter/material.dart';

import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/screens/landingScreen.dart';
import 'package:basic_banking_app/screens/loginScreen.dart';

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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LandingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
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
                          color: kDarkTextColorB,
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        'App',
                        style: TextStyle(
                          color: kDarkTextColor1,
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
                      color: kDarkTextColor1,
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
                color: kDarkTextColorB,
                milliseconds: 200,
                numberOfDots: 5,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'eNeMKreates',
                style: TextStyle(color: kDarkTextColor2),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
