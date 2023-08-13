import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';

class SingleDashItem extends StatelessWidget {
  final String title, subtitle;
  const SingleDashItem(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
