import 'package:flutter/material.dart';

import 'package:line_icons/line_icons.dart';

import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/constants/data.dart';
import 'package:basic_banking_app/models/TransactionModel.dart';
import 'package:basic_banking_app/utils/TimeFormatter.dart';

transactionCardWidget({required TransactionModel transaction}) {
  bool isExpense;
  String user;
  if (transaction.toId == username) {
    isExpense = false;
    user = transaction.fromId;
  } else {
    isExpense = true;
    user = transaction.toId;
  }
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
                    Text(
                      '$user ',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '${transaction.amount}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      getTransactionTime(transaction.date),
                      style: TextStyle(
                        fontSize: 16,
                      ),
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
