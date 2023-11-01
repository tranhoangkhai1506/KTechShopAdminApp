// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktechshopadmin/constants/constants.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';
import 'package:ktechshopadmin/helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:ktechshopadmin/models/products_model/product_models.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final ProductModel productModel;
  final int index;
  const EditProduct(
      {super.key, required this.productModel, required this.index});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Edit Product",
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
                  ? widget.productModel.image.isNotEmpty
                      ? CupertinoButton(
                          onPressed: () {
                            takePicture();
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(widget.productModel.image),
                          ),
                        )
                      : CupertinoButton(
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
                    hintText: widget.productModel.name),
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
                    hintText: widget.productModel.description),
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
                    hintText: "\$${widget.productModel.price.toString()}"),
              ),
              SizedBox(
                height: kMediumPadding,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (image == null &&
                        name.text.isEmpty &&
                        description.text.isEmpty &&
                        price.text.isEmpty) {
                      Navigator.of(context).pop();
                    } else if (image != null) {
                      String imgUrl = await FirebaseStorageHelper.instance
                          .uploadUserImage(widget.productModel.id, image!);
                      ProductModel productModel = widget.productModel.copyWith(
                        description:
                            description.text.isEmpty ? null : description.text,
                        image: imgUrl,
                        name: name.text.isEmpty ? null : name.text,
                        price: price.text.isEmpty ? null : price.text,
                      );
                      appProvider.updateProductList(widget.index, productModel);
                      showMessage("Update Successfully");
                    } else {
                      ProductModel productModel = widget.productModel.copyWith(
                        description:
                            description.text.isEmpty ? null : description.text,
                        name: name.text.isEmpty ? null : name.text,
                        price: price.text.isEmpty ? null : price.text,
                      );
                      appProvider.updateProductList(widget.index, productModel);
                      showMessage("Update Successfully");
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text("Update"))
            ],
          ),
        ));
  }
}
