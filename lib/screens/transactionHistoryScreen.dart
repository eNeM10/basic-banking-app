import 'package:flutter/material.dart';

import 'package:progress_indicators/progress_indicators.dart';

import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/models/TransactionModel.dart';
import 'package:basic_banking_app/utils/Database.dart';
import 'package:basic_banking_app/widgets/transactionCard.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          MaterialButton(
            onPressed: () {
              DatabaseHelper.instance.deleteDatabase();
            },
            color: kDarkTextColorB,
          ),
          Expanded(
            child: FutureBuilder<List<TransactionModel>>(
              future: DatabaseHelper.instance.getTransactions('davidbeckham'),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TransactionModel>> snapshot) {
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
                  if (snapshot.data!.length < 1) {
                    return Center(
                      child: Text(
                        'No Transactions in List',
                        style: TextStyle(color: Colors.white, fontSize: 60),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return TransactionCardWidget(
                          transaction: snapshot.data![index],
                        );
                      },
                      itemCount: snapshot.data!.length,
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
