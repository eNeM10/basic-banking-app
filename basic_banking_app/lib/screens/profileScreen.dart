import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/constants/data.dart';
import 'package:basic_banking_app/models/CustomerModel.dart';
import 'package:basic_banking_app/utils/Database.dart';
import 'package:basic_banking_app/widgets/ProfileImageWidget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<CustomerInfo>(
        future: DatabaseHelper.instance.getCustomerFromID(username),
        builder: (
          BuildContext context,
          AsyncSnapshot<CustomerInfo> userInfo,
        ) {
          if (userInfo.data == null) {
            return Center(
              child: JumpingDotsProgressIndicator(
                fontSize: 60.0,
                color: kDarkTextColorB,
                milliseconds: 200,
                numberOfDots: 5,
              ),
            );
          } else {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      shape: CircleBorder(),
                      minWidth: 45,
                      height: 45,
                      onPressed: () {},
                      child: Icon(
                        LineIcons.edit,
                        size: 30,
                      ),
                    ),
                    MaterialButton(
                      shape: CircleBorder(),
                      minWidth: 45,
                      height: 45,
                      onPressed: () {},
                      child: Icon(
                        LineIcons.cog,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 75,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    shape: BoxShape.circle,
                  ),
                  child: ProfileImageWidget(
                    photoUrl: userInfo.data!.dpurl,
                    radius: 60,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${userInfo.data!.designation} ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      '${userInfo.data!.firstname} ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                      ),
                    ),
                    Text(
                      '${userInfo.data!.lastname}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  userInfo.data!.phone,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  userInfo.data!.id,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
                QrImage(
                  data: userInfo.data!.id,
                  version: QrVersions.auto,
                  size: 200,
                  foregroundColor: Colors.white,
                  embeddedImage: AssetImage('assets/images/Logo.png'),
                  embeddedImageStyle: QrEmbeddedImageStyle(),
                ),
                SizedBox(
                  height: 90,
                ),
                Column(
                  children: [
                    Text(
                      'Made by eNeMKreates',
                      style: TextStyle(color: kDarkTextColor2),
                    ),
                    Text(
                      'Ver 1.0.0',
                      style: TextStyle(color: kDarkTextColor2),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
