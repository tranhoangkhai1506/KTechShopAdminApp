import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/constants.dart';
import 'package:ktechshopadmin/helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:ktechshopadmin/models/categories_model/categories_model.dart';
import 'package:ktechshopadmin/models/user_model/user_model.dart';

class AppProvider with ChangeNotifier {
  List<UserModel> _userList = [];
  List<CategoriesModel> _categoriesList = [];

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

  Future<void> callBackFunction() async {
    await getUserListFun();
    await getCategoriesListFun();
  }

  void updateUserList(int index, UserModel userModel) async {
    await FirebaseFirestoreHelper.instance.updateSingleUser(userModel);
    _userList[index] = userModel;
    notifyListeners();
  }
}
