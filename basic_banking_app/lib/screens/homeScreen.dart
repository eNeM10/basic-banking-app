import 'package:basic_banking_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDarkBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50.0,
          horizontal: 10.0,
        ),
        child: Column(
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
                    style: TextStyle(color: kDarkTextColor1, fontSize: 24),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Mr. Beckham',
                    style: TextStyle(color: kDarkTextColorB, fontSize: 48),
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
                          color: kDarkTextColorB,
                          fontSize: 24,
                        ),
                      ),
                      Material(
                        color: Colors.black,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            LineIcons.syncIcon,
                            color: Colors.white,
                          ),
                          splashRadius: 20.0,
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
                          color: Colors.white,
                          fontSize: 36,
                        ),
                      ),
                      Text(
                        '.59',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'INR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ],
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

class LeftBorderCard extends StatelessWidget {
  const LeftBorderCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: kDarkTextColorB.withOpacity(0.075),
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 4.0,
              color: kDarkTextColorB,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: child,
        ),
      ),
    );
  }
}
