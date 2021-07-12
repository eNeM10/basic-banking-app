import 'package:basic_banking_app/models/CustomerModel.dart';
import 'package:basic_banking_app/screens/secondary_screens/ProfilePopScreen.dart';
import 'package:basic_banking_app/screens/secondary_screens/TransactionPopScreen.dart';
import 'package:basic_banking_app/utils/Database.dart';
import 'package:flutter/material.dart';

import 'package:line_icons/line_icons.dart';

import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/constants/data.dart';
import 'package:basic_banking_app/models/TransactionModel.dart';
import 'package:basic_banking_app/utils/TimeFormatter.dart';
import 'package:progress_indicators/progress_indicators.dart';

class TransactionCardWidget extends StatefulWidget {
  const TransactionCardWidget({required this.transaction, Key? key})
      : super(key: key);
  final TransactionModel transaction;

  @override
  _TransactionCardWidgetState createState() => _TransactionCardWidgetState();
}

class _TransactionCardWidgetState extends State<TransactionCardWidget> {
  @override
  Widget build(BuildContext context) {
    bool isExpense;
    String user;
    String amountInt = widget.transaction.amount.toInt().toString();
    String amountDec =
        ((widget.transaction.amount * 100) - (int.parse(amountInt) * 100))
            .toInt()
            .toString();
    if (widget.transaction.toId == username) {
      isExpense = false;
      user = widget.transaction.fromId;
    } else {
      isExpense = true;
      user = widget.transaction.toId;
    }
    CustomerInfo? userInfo;
    return FutureBuilder<CustomerInfo>(
      future: DatabaseHelper.instance.getCustomerFromID(user),
      builder: (BuildContext context, AsyncSnapshot<CustomerInfo> snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: JumpingDotsProgressIndicator(
              fontSize: 60.0,
              color: kDarkTextColorB,
              milliseconds: 200,
              numberOfDots: 5,
            ),
          );
        } else {
          userInfo = snapshot.data;
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 6.0,
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TransactionPopScreen(
                      transaction: widget.transaction,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.black,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: isExpense ? kExpenseColor : kIncomeColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isExpense
                                  ? LineIcons.arrowRight
                                  : LineIcons.arrowLeft,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      currencySymbol,
                                      style: TextStyle(
                                        fontSize: 23,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          ' $amountInt',
                                          style: TextStyle(
                                            fontSize: 36,
                                          ),
                                        ),
                                        Text(
                                          '.$amountDec',
                                          style: TextStyle(
                                            fontSize: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${userInfo!.designation} ',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${userInfo!.firstname} ',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${userInfo!.lastname} ',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  getTransactionTime(widget.transaction.date),
                                  style: TextStyle(
                                      fontSize: 16, color: kDarkTextColor2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProfilePopScreen(
                                  username: snapshot.data!.id,
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            LineIcons.user,
                            size: 45,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
