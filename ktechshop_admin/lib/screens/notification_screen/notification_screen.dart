import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ktechshopadmin/constants/constants.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _title,
              decoration: InputDecoration(hintText: "Notification Title"),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: _body,
              decoration: InputDecoration(hintText: "Notification Body"),
            ),
            SizedBox(
              height: 12.0,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_body.text.isNotEmpty && _title.text.isNotEmpty) {
                    sendNotificationToAllUsers(
                        appProvider.getUserToken, _title.text, _body.text);
                    _title.clear();
                    _body.clear();
                  } else {
                    showMessage("Fill The Detail");
                  }
                },
                child: Text("Send Notification")),
          ],
        ),
      ),
    );
  }
}

Future<void> sendNotificationToAllUsers(
    List<String?> usersToken, String title, String body) async {
  List<String> newAllUserToken = [];
  List<String> allUserToken = [];

  for (var element in usersToken) {
    if (element != null || element != "") {
      newAllUserToken.add(element!);
      print(element);
    }
  }
  allUserToken = newAllUserToken;
  const String serverKey =
      'AAAA9dCYR6s:APA91bHMVii2HcuRLBwxkIE57aIJQhYWaUjBmbu0bkr9wrMx1KVU6yqhX_rkcvvVODvNuc-u3E3lJ_rkXYkbT4qZyuDg0nod_Vn6Qs9Y_anjZTyvgUzvZKGi9E8izJyA1FRVqBO1zHUw';
  const String firebaseURL = 'https://fcm.googleapis.com/fcm/send';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  final Map<String, dynamic> notification = {
    'title': title,
    'body': body,
  };

  final Map<String, dynamic> requestBody = {
    'notification': notification,
    'priority': 'high',
    'registration_ids': allUserToken,
  };

  final String encodeBody = jsonEncode(requestBody);

  final http.Response response = await http.post(
    Uri.parse(firebaseURL),
    headers: headers,
    body: encodeBody,
  );

  if (response.statusCode == 200) {
    print('Notification sent sucessfully');
  } else {
    print('Notification sending failed with status: ${response.statusCode}');
  }
}
