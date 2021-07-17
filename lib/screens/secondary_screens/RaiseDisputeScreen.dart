import 'package:flutter/material.dart';

import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/models/TransactionModel.dart';

class RaiseDisputeScreen extends StatefulWidget {
  const RaiseDisputeScreen({required this.transaction, Key? key})
      : super(key: key);
  final TransactionModel transaction;
  @override
  _RaiseDisputeScreenState createState() => _RaiseDisputeScreenState();
}

class _RaiseDisputeScreenState extends State<RaiseDisputeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColorDark,
      appBar: AppBar(),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
