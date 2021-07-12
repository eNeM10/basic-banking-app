import 'package:basic_banking_app/constants/colors.dart';
import 'package:flutter/material.dart';

class GetHelpScreen extends StatefulWidget {
  const GetHelpScreen({ Key? key }) : super(key: key);

  @override
  _GetHelpScreenState createState() => _GetHelpScreenState();
}

class _GetHelpScreenState extends State<GetHelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}