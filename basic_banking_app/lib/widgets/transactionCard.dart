import 'package:basic_banking_app/models/CustomerModel.dart';
import 'package:basic_banking_app/utils/Database.dart';
import 'package:flutter/material.dart';

import 'package:line_icons/line_icons.dart';

import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/constants/data.dart';
import 'package:basic_banking_app/models/TransactionModel.dart';
import 'package:basic_banking_app/utils/TimeFormatter.dart';

// class transactionCardWidget extends StatefulWidget {
//   const transactionCardWidget({ Key? key }) : super(key: key);

//   @override
//   _transactionCardWidgetState createState() => _transactionCardWidgetState();
// }

// class _transactionCardWidgetState extends State<transactionCardWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }

transactionCardWidget({required TransactionModel transaction}) {
  bool isExpense;
  String user;
  String amountInt = transaction.amount.toInt().toString();
  String amountDec = ((transaction.amount * 100) - (int.parse(amountInt) * 100))
      .toInt()
      .toString();
  if (transaction.toId == username) {
    isExpense = false;
    user = transaction.fromId;
  } else {
    isExpense = true;
    user = transaction.toId;
  }

  CustomerInfo userInfo = await DatabaseHelper.instance.getCustomerFromID(user);

  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 8.0,
      vertical: 6.0,
    ),
    child: InkWell(
      onTap: () {},
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: isExpense ? kExpenseColor : kIncomeColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isExpense ? LineIcons.arrowRight : LineIcons.arrowLeft,
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
                          crossAxisAlignment: CrossAxisAlignment.baseline,
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
                          '${userInfo.designation} ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '${userInfo.firstname} ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '${userInfo.lastname} ',
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
                      getTransactionTime(transaction.date),
                      style: TextStyle(fontSize: 16, color: kDarkTextColor2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
