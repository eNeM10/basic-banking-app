import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/screens/landingScreen.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'dart:async';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.prefs}) : super(key: key);
  final prefs;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isHidden = true;

  void navigate() async {
    widget.prefs.setBool('login', true);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LandingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/Logo.png',
                    height: 100,
                    width: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MyBank',
                        style: TextStyle(
                          color: kDarkTextColorB,
                          fontSize: 36,
                        ),
                      ),
                      Text(
                        'App',
                        style: TextStyle(
                          color: kDarkTextColor1,
                          fontSize: 36,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 75,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.black,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome',
                                style: TextStyle(
                                  color: kDarkTextColorB,
                                  fontSize: 36,
                                ),
                              ),
                              Text(
                                'Sign in to continue!',
                                style: TextStyle(
                                  color: kDarkTextColor1,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF383838),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                LineIcons.phone,
                                color: kDarkTextColorB,
                              ),
                              hintText: 'Enter phone number',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF383838),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: TextField(
                            obscureText: _isHidden,
                            enableSuggestions: false,
                            autocorrect: false,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isHidden = !_isHidden;
                                  });
                                },
                                icon: Icon(
                                  _isHidden
                                      ? LineIcons.eye
                                      : LineIcons.eyeSlash,
                                  color: kDarkTextColorB,
                                ),
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                LineIcons.key,
                                color: kDarkTextColorB,
                              ),
                              hintText: 'Enter password',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      MaterialButton(
                        onPressed: () {
                          navigate();
                        },
                        color: kDarkTextColorB,
                        height: 50,
                        minWidth: 150,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: kDarkTextColor1,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      MaterialButton(
                        onPressed: () {},
                        color: Colors.transparent,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: kDarkTextColor1,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 75,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
