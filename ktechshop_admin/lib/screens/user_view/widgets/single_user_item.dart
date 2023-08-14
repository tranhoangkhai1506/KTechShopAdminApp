import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';
import 'package:ktechshopadmin/models/user_model/user_model.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:provider/provider.dart';

class SingleUserItem extends StatefulWidget {
  final UserModel userModel;
  const SingleUserItem({super.key, required this.userModel});

  @override
  State<SingleUserItem> createState() => _SingleUserItemState();
}

class _SingleUserItemState extends State<SingleUserItem> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Card(
      color: Theme.of(context).primaryColor.withOpacity(0.5),
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Row(
          children: [
            widget.userModel.image != null
                ? CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(widget.userModel.image!),
                  )
                : CircleAvatar(
                    radius: 35,
                    child: Icon(Icons.person),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      widget.userModel.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  FittedBox(
                    child: Text(
                      widget.userModel.email,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            isLoading
                ? CircularProgressIndicator()
                : IconButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await appProvider
                          .deletedUserFromFirebase(widget.userModel);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    icon: Icon(Icons.delete),
                  )
          ],
        ),
      ),
    );
  }
}
