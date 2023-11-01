// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktechshopadmin/constants/constants.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';
import 'package:ktechshopadmin/models/categories_model/categories_model.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({
    super.key,
  });

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController status = TextEditingController();

  CategoriesModel? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Add Product",
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
                    hintText: "Product Name"),
              ),
              SizedBox(
                height: kMediumPadding,
              ),
              TextFormField(
                controller: description,
                maxLines: 7,
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
                    hintText: "Product Description"),
              ),
              SizedBox(
                height: kMediumPadding,
              ),
              TextFormField(
                controller: price,
                keyboardType: TextInputType.number,
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
                    hintText: "\$ Product Price"),
              ),
              SizedBox(
                height: kMediumPadding,
              ),
              TextFormField(
                controller: status,
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
                    hintText: "Product status"),
              ),
              SizedBox(
                height: kMediumPadding,
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.white,
                ),
                child: DropdownButtonFormField(
                  value: _selectedCategory,
                  hint: Text(
                    'Please Select Category',
                  ),
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  items:
                      appProvider.getCategoriesList.map((CategoriesModel val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(
                        val.name,
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (image == null ||
                        _selectedCategory == null ||
                        name.text.isEmpty ||
                        description.text.isEmpty ||
                        price.text.isEmpty) {
                      showMessage("Please fill all information");
                    } else {
                      appProvider.addProduct(
                        image!,
                        name.text,
                        _selectedCategory!.id,
                        price.text,
                        description.text,
                        status.text,
                      );
                      showMessage("Add Successfully");
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text("Add"))
            ],
          ),
        ));
  }
}
