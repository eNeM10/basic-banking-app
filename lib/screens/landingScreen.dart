import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/screens/allUsersScreen.dart';
import 'package:basic_banking_app/screens/homeScreen.dart';
import 'package:basic_banking_app/screens/profileScreen.dart';
import 'package:basic_banking_app/screens/transactionHistoryScreen.dart';
import 'package:basic_banking_app/widgets/JumpingDots.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({required this.index});
  final int index;
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool loading = false;
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AllUsersScreen(),
    TransactionHistoryScreen(),
    ProfileScreen(),
  ];

  void openAllUsersScreen() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: JumpingDotsProgressIndicator(
              fontSize: 60.0,
              color: kPrimaryColorDark,
              milliseconds: 200,
              numberOfDots: 5,
            ),
          )
        : Scaffold(
            backgroundColor: kBackgroundColorDark,
            body: SafeArea(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: kNavBarColorDark,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black,
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: GNav(
                    rippleColor: kPrimaryColorDark,
                    hoverColor: kPrimaryColorDark,
                    gap: 8,
                    activeColor: kPrimaryTextColorDark,
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    duration: Duration(milliseconds: 200),
                    tabBackgroundColor: kPrimaryColorDark,
                    color: kPrimaryTextColorDark,
                    tabs: [
                      GButton(
                        icon: LineIcons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: LineIcons.users,
                        text: 'Users',
                      ),
                      GButton(
                        icon: LineIcons.history,
                        text: 'Transactions',
                      ),
                      GButton(
                        icon: LineIcons.userEdit,
                        text: 'Profile',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          );
  }
}
