import 'dart:math';
import 'package:flutter/material.dart';


import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/constants/data.dart';
import 'package:basic_banking_app/models/CustomerModel.dart';
import 'package:basic_banking_app/models/ExpensesModel.dart';
import 'package:basic_banking_app/models/IncomeExpenditureModel.dart';
import 'package:basic_banking_app/models/TransactionModel.dart';
import 'package:basic_banking_app/models/QuotesModel.dart';
import 'package:basic_banking_app/screens/landingScreen.dart';
import 'package:basic_banking_app/screens/secondary_screens/ProfilePopScreen.dart';
import 'package:basic_banking_app/utils/Database.dart';
import 'package:basic_banking_app/utils/TransactionsHelper.dart';
import 'package:basic_banking_app/widgets/JumpingDots.dart';
import 'package:basic_banking_app/widgets/ProfileImageWidget.dart';

import 'package:line_icons/line_icons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  List<CustomerInfo> allUsers = [];
  List<TransactionModel> allUserTx = [];
  List<Widget> smallProfileCards = [];

  @override
  void initState() {
    getTopUsers(numberOfUsers: 5);
    super.initState();
  }

  getTopUsers({required int numberOfUsers}) async {
    setState(() {
      loading = true;
    });

    allUsers = await DatabaseHelper.instance.getCustomers(username);
    allUserTx = await DatabaseHelper.instance.getTransactions(username);

    List<String> userIDsTransactedWith = [];
    List<String> userIDsByFrequncy = [];

    for (TransactionModel tx in allUserTx) {
      if (tx.toId == username) {
        userIDsTransactedWith.add(tx.fromId);
      } else {
        userIDsTransactedWith.add(tx.toId);
      }
    }

    TransactionsHelper tf = new TransactionsHelper();
    userIDsByFrequncy = tf.getUsersByFrequency(
      listOfUsers: allUsers,
      userIDs: userIDsTransactedWith,
    );

    for (int i = 0; i < numberOfUsers; i++) {
      for (CustomerInfo user in allUsers) {
        if (userIDsByFrequncy[i] == user.id) {
          smallProfileCards.add(
            SmallProfileCard(
              userInfo: user,
            ),
          );
          break;
        }
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    final List<IncomeExpenditureModel> barChartData = [
      IncomeExpenditureModel(
        month: 'Jun',
        income:
            500000 + random.nextInt(500000).toDouble() + random.nextDouble(),
        expenditure:
            400000 + random.nextInt(500000).toDouble() + random.nextDouble(),
      ),
      IncomeExpenditureModel(
        month: 'May',
        income:
            500000 + random.nextInt(500000).toDouble() + random.nextDouble(),
        expenditure:
            400000 + random.nextInt(500000).toDouble() + random.nextDouble(),
      ),
      IncomeExpenditureModel(
        month: 'Apr',
        income:
            500000 + random.nextInt(500000).toDouble() + random.nextDouble(),
        expenditure:
            400000 + random.nextInt(500000).toDouble() + random.nextDouble(),
      ),
      IncomeExpenditureModel(
        month: 'Mar',
        income:
            500000 + random.nextInt(500000).toDouble() + random.nextDouble(),
        expenditure:
            400000 + random.nextInt(500000).toDouble() + random.nextDouble(),
      ),
      IncomeExpenditureModel(
        month: 'Feb',
        income:
            500000 + random.nextInt(500000).toDouble() + random.nextDouble(),
        expenditure:
            400000 + random.nextInt(500000).toDouble() + random.nextDouble(),
      ),
      IncomeExpenditureModel(
        month: 'Jan',
        income:
            500000 + random.nextInt(500000).toDouble() + random.nextDouble(),
        expenditure:
            400000 + random.nextInt(500000).toDouble() + random.nextDouble(),
      ),
    ];
    final List<ExpensesModel> pieChartData = [
      ExpensesModel(category: 'Home', amount: 3000, size: '94%'),
      ExpensesModel(category: 'Entertainment', amount: 5000, size: '100%'),
      ExpensesModel(category: 'Health', amount: 1500, size: '91%'),
      ExpensesModel(category: 'Bills', amount: 1000, size: '88%'),
      ExpensesModel(category: 'Other', amount: 4500, size: '97%'),
    ];

    final QuotesModel quote = quotes[random.nextInt(10)];

    return loading
        ? Center(
            child: JumpingDotsProgressIndicator(),
          )
        : Container(
            color: kBackgroundColorDark,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Good Morning,',
                          style: TextStyle(
                            color: kPrimaryTextColorDark,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Mr. Beckham',
                          style: TextStyle(
                            color: kHeadTextColorDark,
                            fontSize: 48,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  LeftBorderCard(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Balance',
                              style: TextStyle(
                                color: kHeadTextColorDark,
                                fontSize: 24,
                              ),
                            ),
                            Container(
                              width: 55,
                              child: MaterialButton(
                                shape: CircleBorder(),
                                onPressed: () {},
                                color: Colors.transparent,
                                child: Icon(
                                  LineIcons.syncIcon,
                                  color: kPrimaryTextColorDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '1,985,647',
                              style: TextStyle(
                                color: kPrimaryTextColorDark,
                                fontSize: 36,
                              ),
                            ),
                            Text(
                              '.59',
                              style: TextStyle(
                                color: kPrimaryTextColorDark,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'USD',
                              style: TextStyle(
                                color: kPrimaryTextColorDark,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Row(
                            children: smallProfileCards,
                          ),
                          MaterialButton(
                            shape: CircleBorder(),
                            minWidth: 70.0,
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LandingScreen(index: 1),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    LineIcons.chevronRight,
                                    size: 35,
                                    color: kPrimaryColorDark,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'See All',
                                  style:
                                      TextStyle(color: kPrimaryTextColorDark),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: LeftBorderCard(
                          child: SizedBox(
                            height: 150,
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rewards',
                                  style: TextStyle(
                                    color: kHeadTextColorDark,
                                    fontSize: 24,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          '$currencySymbol',
                                          style: TextStyle(
                                            color: kPrimaryTextColorDark,
                                            fontSize: 25,
                                          ),
                                        ),
                                        Text(
                                          '1,205',
                                          style: TextStyle(
                                            color: kPrimaryTextColorDark,
                                            fontSize: 35,
                                          ),
                                        ),
                                        Text(
                                          '.50',
                                          style: TextStyle(
                                            color: kPrimaryTextColorDark,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 16.0, bottom: 10),
                                  child: Center(
                                    child: Text(
                                      'Rewards Earned',
                                      style: TextStyle(
                                        color: kSecondaryTextColorDark,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: LeftBorderCard(
                          child: SizedBox(
                            height: 150,
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bills',
                                  style: TextStyle(
                                    color: kHeadTextColorDark,
                                    fontSize: 24,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Center(
                                    child: Text(
                                      '3',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: kPrimaryTextColorDark,
                                        fontSize: 48,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 16.0,
                                    bottom: 10,
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          'bills due',
                                          style: TextStyle(
                                            color: kSecondaryTextColorDark,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          'this week',
                                          style: TextStyle(
                                            color: kSecondaryTextColorDark,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  LeftBorderCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'I&E Overview',
                          style: TextStyle(
                            color: kHeadTextColorDark,
                            fontSize: 24,
                          ),
                        ),
                        Container(
                          child: SfCartesianChart(
                            palette: [
                              kPositiveColorDark,
                              kNegativeColorDark,
                            ],
                            plotAreaBorderColor: Colors.transparent,
                            primaryXAxis: CategoryAxis(
                              isVisible: true,
                              axisLine: AxisLine(
                                color: Colors.transparent,
                              ),
                              majorGridLines: MajorGridLines(
                                color: Colors.transparent,
                              ),
                              minorGridLines: MinorGridLines(
                                color: Colors.transparent,
                              ),
                              majorTickLines: MajorTickLines(
                                color: Colors.transparent,
                              ),
                            ),
                            primaryYAxis: NumericAxis(
                              isVisible: false,
                            ),
                            series: <CartesianSeries>[
                              ColumnSeries<IncomeExpenditureModel, String>(
                                dataSource: barChartData,
                                xValueMapper:
                                    (IncomeExpenditureModel data, _) =>
                                        data.month,
                                yValueMapper:
                                    (IncomeExpenditureModel data, _) =>
                                        data.income,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                spacing: 0.2,
                              ),
                              ColumnSeries<IncomeExpenditureModel, String>(
                                dataSource: barChartData,
                                xValueMapper:
                                    (IncomeExpenditureModel data, _) =>
                                        data.month,
                                yValueMapper:
                                    (IncomeExpenditureModel data, _) =>
                                        data.expenditure,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                spacing: 0.2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  LeftBorderCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expenses',
                          style: TextStyle(
                            color: kHeadTextColorDark,
                            fontSize: 24,
                          ),
                        ),
                        Container(
                          child: SfCircularChart(
                            legend: Legend(
                              alignment: ChartAlignment.far,
                              isVisible: true,
                              textStyle: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            series: <CircularSeries>[
                              PieSeries<ExpensesModel, String>(
                                dataSource: pieChartData,
                                xValueMapper: (ExpensesModel data, _) =>
                                    data.category,
                                yValueMapper: (ExpensesModel data, _) =>
                                    data.amount,
                                pointRadiusMapper: (ExpensesModel data, _) =>
                                    data.size,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            quote.quote,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kSecondaryTextColorDark,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              '- ${quote.author}',
                              style: TextStyle(
                                color: kSecondaryTextColorDark,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class SmallProfileCard extends StatelessWidget {
  const SmallProfileCard({required this.userInfo});

  final CustomerInfo userInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProfilePopScreen(
                user: userInfo,
              ),
            ),
          );
        },
        child: Column(
          children: [
            // CircleAvatar(
            //   radius: 35,
            //   backgroundImage: image,
            // ),
            ProfileImageWidget(
              photoUrl: userInfo.dpurl,
              radius: 35,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              userInfo.firstname,
              style: TextStyle(color: kSecondaryTextColorDark),
            ),
          ],
        ),
      ),
    );
  }
}

class LeftBorderCard extends StatelessWidget {
  const LeftBorderCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
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
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                width: 4.0,
                color: kPrimaryColorDark,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
