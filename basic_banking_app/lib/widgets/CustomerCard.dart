import 'package:basic_banking_app/widgets/ProfileImageWidget.dart';
import 'package:flutter/material.dart';

customerCardWidget({customer, onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 8.0,
      vertical: 6.0,
    ),
    child: InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  shape: BoxShape.circle,
                ),
                child: ProfileImageWidget(
                  photoUrl: customer.dpurl,
                  radius: 30,
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
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${customer.designation} ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '${customer.firstname} ',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          '${customer.lastname}',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${customer.id}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${customer.phone}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
