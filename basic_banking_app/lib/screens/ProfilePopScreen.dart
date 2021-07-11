import 'package:basic_banking_app/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfilePopScreen extends StatefulWidget {
  const ProfilePopScreen({required this.username, Key? key}) : super(key: key);
  final String username;
  @override
  _ProfilePopScreenState createState() => _ProfilePopScreenState();
}

class _ProfilePopScreenState extends State<ProfilePopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        title: Text('Profile: ${widget.username}'),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
