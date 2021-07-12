import 'package:basic_banking_app/screens/secondary_screens/ProfilePopScreen.dart';
import 'package:flutter/material.dart';

import 'package:progress_indicators/progress_indicators.dart';

import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/models/CustomerModel.dart';
import 'package:basic_banking_app/utils/Database.dart';
import 'package:basic_banking_app/widgets/CustomerCard.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({Key? key}) : super(key: key);

  @override
  _AllUsersScreenState createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
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
            child: FutureBuilder<List<CustomerInfo>>(
              future: DatabaseHelper.instance.getCustomers('davidbeckham'),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<CustomerInfo>> snapshot,
              ) {
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
                        'No Customers in List',
                        style: TextStyle(color: Colors.white, fontSize: 60),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return customerCardWidget(
                          customer: snapshot.data![index],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfilePopScreen(
                                username: snapshot.data![index].id,
                              ),
                            ),
                          ),
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
