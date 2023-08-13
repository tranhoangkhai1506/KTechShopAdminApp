import 'package:flutter/material.dart';
import 'package:ktechshopadmin/helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:ktechshopadmin/models/categories_model/categories_model.dart';
import 'package:ktechshopadmin/models/user_model/user_model.dart';

class AppProvider with ChangeNotifier {
  List<UserModel> _userList = [];
  List<CategoriesModel> _categoriesList = [];

  Future<void> getUserListFun() async {
    _userList = await FirebaseFirestoreHelper.instance.getUserList();
  }

  Future<void> getCategoriesListFun() async {
    _categoriesList = await FirebaseFirestoreHelper.instance.getCategory();
  }

  List<UserModel> get getUserList => _userList;
  List<CategoriesModel> get getCategoriesList => _categoriesList;

  void callBackFunction() async {
    await getUserListFun();
    await getCategoriesListFun();
  }
}
