import 'package:flutter/material.dart';

import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/utils/CustomRectTween.dart';
import 'package:basic_banking_app/utils/PopDialogRoute.dart';
import 'package:basic_banking_app/widgets/AddTxScreens.dart';

import 'package:line_icons/line_icons.dart';

class AddTxButton extends StatelessWidget {
  AddTxButton({
    required this.toID,
    required this.toName,
    this.isRequest = false,
    Key? key,
  }) : super(key: key);
  final String toID;
  final String toName;
  final bool isRequest;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: isRequest ? _heroRequestTx : _heroSendTx,
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin, end: end);
      },
      child: MaterialButton(
        onPressed: () {
          Navigator.of(context).push(
            PopDialogRoute(
              builder: (context) {
                return _AddTxPopupCard(
                  toID: toID,
                  toName: toName,
                  isRequest: isRequest,
                );
              },
            ),
          );
        },
        color: kPrimaryColorDark,
        elevation: 6,
        padding: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isRequest ? LineIcons.arrowDown : LineIcons.arrowUp,
            ),
            SizedBox(
              width: 10,
            ),
            Text(isRequest ? 'Request Money  ' : 'Send Money  '),
          ],
        ),
      ),
    );
  }
}

/// Tag-value used for the add todo popup button.
const String _heroSendTx = 'request-money-hero';
const String _heroRequestTx = 'send-money-hero';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTx].
/// {@endtemplate}
class _AddTxPopupCard extends StatelessWidget {
  const _AddTxPopupCard({
    required this.toID,
    required this.toName,
    required this.isRequest,
    Key? key,
  }) : super(key: key);
  final String toID;
  final String toName;
  final bool isRequest;
  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        // if (!currentFocus.hasPrimaryFocus) {
        //   currentFocus.unfocus();
        // } else {
        //   Navigator.of(context).pop();
        // }
        if (MediaQuery.of(context).viewInsets.bottom != 0) {
          currentFocus.unfocus();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Hero(
                tag: isRequest ? _heroRequestTx : _heroSendTx,
                createRectTween: (begin, end) {
                  return CustomRectTween(begin: begin, end: end);
                },
                child: Material(
                  color: kCardColorDark,
                  shadowColor: kPrimaryColorDark,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SendMoneyCard(
                        toName: toName,
                        toID: toID,
                        isRequest: isRequest,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
