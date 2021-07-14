import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget(
      {required this.photoUrl, required this.radius, Key? key})
      : super(key: key);
  final String photoUrl;
  final double radius;
  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  @override
  Widget build(BuildContext context) {
    double radius = widget.radius;
    return CircleAvatar(
      backgroundColor: Colors.orangeAccent[400],
      radius: widget.radius,
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          height: radius*2,
          width: radius*2,
          fit: BoxFit.cover,
          placeholder: 'assets/images/Loader.gif',
          image: widget.photoUrl,
          imageErrorBuilder: (context, exception, stackTrace) {
            return CircleAvatar(
              backgroundColor: Colors.orangeAccent[400],
              radius: radius,
              child: Icon(
                LineIcons.user,
                color: Colors.black,
                size: radius*2,
              ),
            );
          },
        ),
      ),
    );
  }
}
