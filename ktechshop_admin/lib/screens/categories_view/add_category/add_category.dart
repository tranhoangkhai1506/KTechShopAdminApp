// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktechshopadmin/constants/constants.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _EditProfileState();
}

class _EditProfileState extends State<AddCategory> {
  File? image;

  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Edit Category",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            children: [
              image == null
                  ? CupertinoButton(
                      onPressed: () {
                        takePicture();
                      },
                      child: CircleAvatar(
                          radius: 50, child: Icon(Icons.camera_alt)),
                    )
                  : CupertinoButton(
                      onPressed: () {
                        takePicture();
                      },
                      child: CircleAvatar(
                          radius: 50, backgroundImage: FileImage(image!)),
                    ),
              SizedBox(
                height: kDefaultPadding,
              ),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kDefaultPadding),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kDefaultPadding),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kDefaultPadding),
                    ),
                    hintText: "Name"),
              ),
              SizedBox(
                height: kMediumPadding,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (image == null && name.text.isEmpty) {
                      Navigator.of(context).pop();
                    } else if (image != null && name.text.isNotEmpty) {
                      appProvider.addCategory(image!, name.text);
                      showMessage("Successfully Added");
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text("Add"))
            ],
          ),
        ));
  }
}
