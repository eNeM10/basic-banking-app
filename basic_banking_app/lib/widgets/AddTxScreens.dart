import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/constants/data.dart';
import 'package:basic_banking_app/models/TransactionModel.dart';
import 'package:basic_banking_app/utils/Database.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:uuid/uuid.dart';

class SendMoneyCard extends StatefulWidget {
  const SendMoneyCard({
    Key? key,
    required this.toName,
    required this.toID,
    required this.isRequest,
  }) : super(key: key);

  final String toName;
  final String toID;
  final bool isRequest;

  @override
  _SendMoneyCardState createState() => _SendMoneyCardState();
}

class _SendMoneyCardState extends State<SendMoneyCard> {
  int stage = 0;
  double amount = 0.0;
  TextEditingController amountTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (stage == 0) {
      return SizedBox(
        height: 350.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.isRequest ? 'Request Money From' : 'Send Money To',
              style: TextStyle(color: kDarkTextColor2, fontSize: 18),
            ),
            Text(
              '${widget.toName}',
              style: TextStyle(color: Colors.white, fontSize: 36),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: amountTextController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                labelStyle: TextStyle(
                  fontSize: 18,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.2,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter a message (Optional)',
                labelStyle: TextStyle(
                  fontSize: 18,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 18,
              ),
              textInputAction: TextInputAction.done,
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.2,
            ),
            MaterialButton(
              onPressed: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                setState(() {
                  try {
                    amount = double.parse(amountTextController.text);
                    stage = 1;
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text('Enter valid amount'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                });
              },
              child: Text(
                widget.isRequest ? 'Request' : 'Send',
                style: TextStyle(
                  color: kDarkTextColorB,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (stage == 1) {
      String amountInt = amount.toInt().toString();
      String amountDec = ((amount * 100) - (int.parse(amountInt) * 100))
          .toInt()
          .toString()
          .padLeft(2, '0');
      return SizedBox(
        height: 350.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.isRequest ? 'Request Money From' : 'Send Money To',
              style: TextStyle(color: kDarkTextColor2, fontSize: 18),
            ),
            Text(
              '${widget.toName}',
              style: TextStyle(color: Colors.white, fontSize: 36),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '$currencySymbol',
                  style: TextStyle(color: Colors.white, fontSize: 36),
                ),
                Text(
                  '$amountInt',
                  style: TextStyle(color: Colors.white, fontSize: 60),
                ),
                Text(
                  '.$amountDec',
                  style: TextStyle(color: Colors.white, fontSize: 36),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () {
                widget.isRequest
                    ? sendRequest(
                        amount: amount,
                        toID: widget.toID,
                      )
                    : sendMoney(
                        amount: amount,
                        toID: widget.toID,
                      );
                setState(() {
                  stage = 2;
                });
                // Navigator.of(context).pop();
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: kDarkTextColorB,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (stage == 2) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: SizedBox(
          width: double.infinity,
          height: 350.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LineIcons.check,
                size: 64,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Transaction Successful',
                style: TextStyle(fontSize: 24),
              )
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Text('Error'),
      );
    }
  }

  void sendMoney({required double amount, required String toID}) async {
    var uuid = Uuid();
    TransactionModel tx = TransactionModel(
      txId: uuid.v1(),
      toId: toID,
      fromId: username,
      amount: amount,
      date: DateTime.now(),
    );
    DatabaseHelper.instance.makeTransaction(tx);
    print('Sent \$$amount to $toID');
  }

  void sendRequest({required double amount, required String toID}) async {
    print('Request \$$amount to $toID');
  }
}
