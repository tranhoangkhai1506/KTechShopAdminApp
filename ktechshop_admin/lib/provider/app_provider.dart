import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/constants.dart';
import 'package:ktechshopadmin/helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:ktechshopadmin/models/categories_model/categories_model.dart';
import 'package:ktechshopadmin/models/order_model/order_model.dart';
import 'package:ktechshopadmin/models/products_model/product_models.dart';
import 'package:ktechshopadmin/models/user_model/user_model.dart';

class AppProvider with ChangeNotifier {
  List<UserModel> _userList = [];
  List<CategoriesModel> _categoriesList = [];
  List<ProductModel> _productList = [];
  List<OrderModel> _completedOrderList = [];
  List<OrderModel> _cancelOrderList = [];
  List<OrderModel> _pendingOrderList = [];
  List<OrderModel> _deliveryOrderList = [];
  List<String?> _usersToken = [];

  double _totalEarning = 0.0;

  Future<void> getUserListFun() async {
    _userList = await FirebaseFirestoreHelper.instance.getUserList();
    _usersToken = _userList.map((e) => e.notificationToken).toList();
  }

  Future<void> getCompletedOrder() async {
    _completedOrderList =
        await FirebaseFirestoreHelper.instance.getCompletedOrder();
    for (var element in _completedOrderList) {
      _totalEarning += element.totalPrice;
    }
    notifyListeners();
  }

  Future<void> getCancelOrder() async {
    _cancelOrderList = await FirebaseFirestoreHelper.instance.getCancelOrder();

    notifyListeners();
  }

  Future<void> getPendingOrder() async {
    _pendingOrderList =
        await FirebaseFirestoreHelper.instance.getPendingOrder();

    notifyListeners();
  }

  Future<void> getDeliveryOrder() async {
    _deliveryOrderList =
        await FirebaseFirestoreHelper.instance.getDeliveryOrder();

    notifyListeners();
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
  double get getTotalEarning => _totalEarning;
  List<CategoriesModel> get getCategoriesList => _categoriesList;
  List<ProductModel> get getProducts => _productList;
  List<OrderModel> get getCompletedOrderList => _completedOrderList;
  List<OrderModel> get getCancelOrderList => _cancelOrderList;
  List<OrderModel> get getPendingOrderList => _pendingOrderList;
  List<OrderModel> get getDeliveryOrderList => _deliveryOrderList;
  List<String?> get getUserToken => _usersToken;

  Future<void> callBackFunction() async {
    await getUserListFun();
    await getCategoriesListFun();
    await getProduct();
    await getCompletedOrder();
    await getCancelOrder();
    await getPendingOrder();
    await getDeliveryOrder();
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

  Future<void> deletedProductFromFirebase(ProductModel productModel) async {
    String value = await FirebaseFirestoreHelper.instance
        .deleteSingleProduct(productModel.categoryId, productModel.id);
    if (value == "Successfully Deleted") {
      _productList.remove(productModel);
      showMessage("Successfully Deleted");
    }
    notifyListeners();
  }

  void updateProductList(int index, ProductModel productModel) async {
    await FirebaseFirestoreHelper.instance.updateSingleProduct(productModel);
    _productList[index] = productModel;
    notifyListeners();
  }

  void addProduct(
    File image,
    String name,
    String categoryId,
    String price,
    String description,
    String status,
  ) async {
    ProductModel productModel = await FirebaseFirestoreHelper.instance
        .addSingleProduct(image, name, categoryId, price, description, status);
    _productList.add(productModel);
    notifyListeners();
  }

  void updatePendingOrder(OrderModel order) {
    _deliveryOrderList.add(order);
    _pendingOrderList.remove(order);
    notifyListeners();
    showMessage("Send To Delivery");
  }

  void updateCancelPendingOrder(OrderModel order) {
    _cancelOrderList.add(order);
    _pendingOrderList.remove(order);
    showMessage("Succefully Cancel");
    notifyListeners();
  }

  void updateCancelDeliveryOrder(OrderModel order) {
    _cancelOrderList.add(order);
    _deliveryOrderList.remove(order);
    showMessage("Succefully Cancel");
    notifyListeners();
  }
}
