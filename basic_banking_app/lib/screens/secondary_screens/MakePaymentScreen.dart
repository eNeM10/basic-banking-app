import 'package:basic_banking_app/models/CustomerModel.dart';
import 'package:flutter/material.dart';

class MakePaymentScreen extends StatefulWidget {
  const MakePaymentScreen({required this.user, Key? key}) : super(key: key);
  final CustomerInfo user;
  @override
  _MakePaymentScreenState createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
