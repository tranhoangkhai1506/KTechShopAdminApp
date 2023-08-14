import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';
import 'package:ktechshopadmin/models/user_model/user_model.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:ktechshopadmin/screens/user_view/widgets/single_user_item.dart';
import 'package:provider/provider.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User View'),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Consumer<AppProvider>(
            builder: (context, value, child) {
              return ListView.builder(
                  padding: EdgeInsets.all(kDefaultPadding),
                  itemCount: value.getUserList.length,
                  itemBuilder: (context, index) {
                    UserModel userModel = value.getUserList[index];
                    return SingleUserItem(userModel: userModel);
                  });
            },
          ),
        ));
  }
}
