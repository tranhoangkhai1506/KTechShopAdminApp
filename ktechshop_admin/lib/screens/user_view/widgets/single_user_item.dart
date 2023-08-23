import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';
import 'package:ktechshopadmin/constants/routes.dart';
import 'package:ktechshopadmin/models/user_model/user_model.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:ktechshopadmin/screens/user_view/edit_user/edit_user.dart';
import 'package:provider/provider.dart';

class SingleUserItem extends StatefulWidget {
  final UserModel userModel;
  final int index;
  const SingleUserItem(
      {super.key, required this.userModel, required this.index});

  @override
  State<SingleUserItem> createState() => _SingleUserItemState();
}

class _SingleUserItemState extends State<SingleUserItem> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Card(
      color: Colors.white
          .withOpacity(0.8), //Theme.of(context).primaryColor.withOpacity(0.5),
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Row(
          children: [
            widget.userModel.image != null
                ? CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(widget.userModel.image!),
                  )
                : CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userModel.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  Text(
                    widget.userModel.email,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                Routes.instance.push(
                    widget: EditProfile(
                        index: widget.index, userModel: widget.userModel),
                    context: context);
              },
              child: Icon(Icons.edit),
            ),
            SizedBox(width: kDefaultPadding),
            isLoading
                ? CircularProgressIndicator()
                : GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await appProvider
                          .deletedUserFromFirebase(widget.userModel);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Icon(Icons.delete,
                        color: const Color.fromARGB(255, 239, 84, 73)),
                  ),
          ],
        ),
      ),
    );
  }
}
