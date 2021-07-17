import 'package:flutter/material.dart';

import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/constants/data.dart';
import 'package:basic_banking_app/models/CustomerModel.dart';
import 'package:basic_banking_app/models/TransactionModel.dart';
import 'package:basic_banking_app/screens/secondary_screens/ProfilePopScreen.dart';
import 'package:basic_banking_app/screens/secondary_screens/TransactionPopScreen.dart';
import 'package:basic_banking_app/utils/Database.dart';
import 'package:basic_banking_app/utils/TimeFormatter.dart';
import 'package:basic_banking_app/widgets/JumpingDots.dart';
import 'package:basic_banking_app/widgets/ProfileImageWidget.dart';

import 'package:line_icons/line_icons.dart';

// ignore: must_be_immutable
class TransactionCardWidget extends StatefulWidget {
  TransactionCardWidget(
      {required this.transaction, this.compact = false, Key? key})
      : super(key: key);
  final TransactionModel transaction;
  late bool compact;

  @override
  _TransactionCardWidgetState createState() => _TransactionCardWidgetState();
}

class _TransactionCardWidgetState extends State<TransactionCardWidget> {
  @override
  Widget build(BuildContext context) {
    bool isExpense;
    bool isCompact = widget.compact;
    String user;
    String amountInt = widget.transaction.amount.toInt().toString();
    String amountDec =
        ((widget.transaction.amount * 100) - (int.parse(amountInt) * 100))
            .toInt()
            .toString()
            .padLeft(2, '0');
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
              color: kPrimaryColorDark,
              milliseconds: 200,
              numberOfDots: 5,
            ),
          );
        } else {
          userInfo = snapshot.data;
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 16.0 : 8.0,
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
                  color: kCardColorDark,
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
                              color: isExpense
                                  ? kNegativeColorDark
                                  : kPositiveColorDark,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isExpense
                                  ? LineIcons.arrowRight
                                  : LineIcons.arrowLeft,
                              size: 50,
                              color: kPrimaryTextColorDark,
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
                                Container(
                                  child: isCompact
                                      ? Container()
                                      : Row(
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
                                ),
                                SizedBox(
                                  height: isCompact ? 1 : 5,
                                ),
                                Text(
                                  getTransactionTime(widget.transaction.date),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: kSecondaryTextColorDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      isCompact
                          ? Container()
                          : Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: kAccentColorDark,
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ProfilePopScreen(
                                        user: snapshot.data!,
                                      ),
                                    ),
                                  );
                                },
                                child: ProfileImageWidget(
                                  photoUrl: userInfo!.dpurl,
                                  radius: 30,
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
