import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/constants.dart';
import 'package:ktechshopadmin/helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:ktechshopadmin/models/categories_model/categories_model.dart';
import 'package:ktechshopadmin/models/products_model/product_models.dart';
import 'package:ktechshopadmin/models/user_model/user_model.dart';

class AppProvider with ChangeNotifier {
  List<UserModel> _userList = [];
  List<CategoriesModel> _categoriesList = [];
  List<ProductModel> _productList = [];

  Future<void> getUserListFun() async {
    _userList = await FirebaseFirestoreHelper.instance.getUserList();
  }

  Future<void> deletedUserFromFirebase(UserModel userModel) async {
    String value =
        await FirebaseFirestoreHelper.instance.deleteSingleUser(userModel.id);
    if (value == "Successfully Deleted") {
      _userList.remove(userModel);
      showMessage("Successfully Deleted");
    }
    notifyListeners();
  }

  Future<void> getCategoriesListFun() async {
    _categoriesList = await FirebaseFirestoreHelper.instance.getCategory();
  }

  List<UserModel> get getUserList => _userList;
  List<CategoriesModel> get getCategoriesList => _categoriesList;
  List<ProductModel> get getProducts => _productList;

  Future<void> callBackFunction() async {
    await getUserListFun();
    await getCategoriesListFun();
    await getProduct();
  }

  void updateUserList(int index, UserModel userModel) async {
    await FirebaseFirestoreHelper.instance.updateSingleUser(userModel);
    _userList[index] = userModel;
    notifyListeners();
  }

  //cate
  Future<void> deletedCaterogyFromFirebase(
      CategoriesModel categoriesModel) async {
    String value = await FirebaseFirestoreHelper.instance
        .deleteSingleCaterogy(categoriesModel.id);
    if (value == "Successfully Deleted") {
      _categoriesList.remove(categoriesModel);
      showMessage("Successfully Deleted");
    }
    notifyListeners();
  }

  void updateCaterogyList(int index, CategoriesModel categoriesModel) async {
    await FirebaseFirestoreHelper.instance
        .updateSingleCaterogy(categoriesModel);
    _categoriesList[index] = categoriesModel;
    notifyListeners();
  }

  void addCategory(File image, String name) async {
    CategoriesModel categoriesModel =
        await FirebaseFirestoreHelper.instance.addSingleCaterogy(image, name);
    _categoriesList.add(categoriesModel);
    notifyListeners();
  }

  Future<void> getProduct() async {
    _productList = await FirebaseFirestoreHelper.instance.getProducts();
    notifyListeners();
  }
}
