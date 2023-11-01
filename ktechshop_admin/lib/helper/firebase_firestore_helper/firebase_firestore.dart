// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ktechshopadmin/constants/constants.dart';
import 'package:ktechshopadmin/helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:ktechshopadmin/models/categories_model/categories_model.dart';
import 'package:ktechshopadmin/models/order_model/order_model.dart';
import 'package:ktechshopadmin/models/products_model/product_models.dart';
import 'package:ktechshopadmin/models/user_model/user_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getUserList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection('users').get();
    return querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  Future<List<CategoriesModel>> getCategory() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("catagories").get();
      List<CategoriesModel> categoriesList = querySnapshot.docs
          .map((e) => CategoriesModel.fromJson(e.data()))
          .toList();
      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<String> deleteSingleUser(String id) async {
    try {
      await _firebaseFirestore.collection("users").doc(id).delete();
      return "Successfully Deleted";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSingleUser(UserModel userModel) async {
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(userModel.id)
          .update(userModel.toJson());
    } catch (e) {
      //
    }
  }

  Future<String> deleteSingleCaterogy(String id) async {
    try {
      await _firebaseFirestore.collection("catagories").doc(id).delete();
      return "Successfully Deleted";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSingleCaterogy(CategoriesModel categoriesModel) async {
    try {
      await _firebaseFirestore
          .collection("catagories")
          .doc(categoriesModel.id)
          .update(categoriesModel.toJson());
    } catch (e) {
      //
    }
  }

  Future<CategoriesModel> addSingleCaterogy(File image, String name) async {
    DocumentReference reference =
        _firebaseFirestore.collection("catagories").doc();
    String imageUrl = await FirebaseStorageHelper.instance
        .uploadUserImage(reference.id, image);
    CategoriesModel addCategory =
        CategoriesModel(id: reference.id, image: imageUrl, name: name);
    await reference.set(addCategory.toJson());
    return addCategory;
  }

  Future<List<ProductModel>> getProducts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collectionGroup("products").get();
    List<ProductModel> productList =
        querySnapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    return productList;
  }

  Future<String> deleteSingleProduct(
      String categoryId, String productId) async {
    try {
      await _firebaseFirestore
          .collection("catagories")
          .doc(categoryId)
          .collection("products")
          .doc(productId)
          .delete();
      return "Successfully Deleted";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSingleProduct(ProductModel productModel) async {
    try {
      await _firebaseFirestore
          .collection("catagories")
          .doc(productModel.categoryId)
          .collection("products")
          .doc(productModel.id)
          .update(productModel.toJson());
    } catch (e) {
      //
    }
  }

  Future<ProductModel> addSingleProduct(
    File image,
    String name,
    String categoryId,
    String price,
    String description,
    String status,
  ) async {
    DocumentReference reference = _firebaseFirestore
        .collection("catagories")
        .doc(categoryId)
        .collection("products")
        .doc();
    String imageUrl = await FirebaseStorageHelper.instance
        .uploadUserImage(reference.id, image);
    ProductModel addProduct = ProductModel(
      id: reference.id,
      image: imageUrl,
      name: name,
      categoryId: categoryId,
      description: description,
      isFavourite: false,
      price: double.parse(price),
      status: status,
      quantity: 1,
    );
    await reference.set(addProduct.toJson());
    return addProduct;
  }

  Future<List<OrderModel>> getCompletedOrder() async {
    QuerySnapshot<Map<String, dynamic>> completedOrder =
        await _firebaseFirestore
            .collection("orders")
            .where("status", isEqualTo: "Completed")
            .get();
    List<OrderModel> completedOrderList = completedOrder.docs
        .map((e) => OrderModel.fromJson(
              e.data(),
            ))
        .toList();
    return completedOrderList;
  }

  Future<List<OrderModel>> getCancelOrder() async {
    QuerySnapshot<Map<String, dynamic>> cancelOrder = await _firebaseFirestore
        .collection("orders")
        .where("status", isEqualTo: "Cancel")
        .get();
    List<OrderModel> cancelOrderList = cancelOrder.docs
        .map((e) => OrderModel.fromJson(
              e.data(),
            ))
        .toList();
    return cancelOrderList;
  }

  Future<List<OrderModel>> getPendingOrder() async {
    QuerySnapshot<Map<String, dynamic>> pendingOrder = await _firebaseFirestore
        .collection("orders")
        .where("status", isEqualTo: "Pending")
        .get();
    List<OrderModel> pendingOrderList = pendingOrder.docs
        .map((e) => OrderModel.fromJson(
              e.data(),
            ))
        .toList();
    return pendingOrderList;
  }

  Future<List<OrderModel>> getDeliveryOrder() async {
    QuerySnapshot<Map<String, dynamic>> deliveryOrder = await _firebaseFirestore
        .collection("orders")
        .where("status", isEqualTo: "Delivery")
        .get();
    List<OrderModel> deliveryOrderList = deliveryOrder.docs
        .map((e) => OrderModel.fromJson(
              e.data(),
            ))
        .toList();
    return deliveryOrderList;
  }

  Future<void> updateOrder(OrderModel orderModel, String status) async {
    await _firebaseFirestore
        .collection("usersOrders")
        .doc(orderModel.userId)
        .collection("orders")
        .doc(orderModel.orderid)
        .update({
      "status": status,
    });

    await _firebaseFirestore
        .collection("orders")
        .doc(orderModel.orderid)
        .update({
      "status": status,
    });
  }

  // Future<List<ProductModel>> getBestProducts() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await _firebaseFirestore.collectionGroup("products").get();
  //     List<ProductModel> bestProductList = querySnapshot.docs
  //         .map((e) => ProductModel.fromJson(e.data()))
  //         .toList();
  //     return bestProductList;
  //   } catch (e) {
  //     showMessage(e.toString());
  //     return [];
  //   }
  // }

  // Future<List<ProductModel>> getCategoryViewProduct(String id) async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await _firebaseFirestore
  //             .collection("catagories")
  //             .doc(id)
  //             .collection("products")
  //             .get();
  //     List<ProductModel> bestProductList = querySnapshot.docs
  //         .map((e) => ProductModel.fromJson(e.data()))
  //         .toList();
  //     return bestProductList;
  //   } catch (e) {
  //     showMessage(e.toString());
  //     return [];
  //   }
  // }

  // Future<UserModel> getUserInformation() async {
  //   DocumentSnapshot<Map<String, dynamic>> querySnapshot =
  //       await _firebaseFirestore
  //           .collection("users")
  //           .doc(FirebaseAuth.instance.currentUser!.uid)
  //           .get();
  //   return UserModel.fromJson(querySnapshot.data()!);
  // }

  // Future<bool> uploadOrderProductFirebase(
  //     List<ProductModel> list, BuildContext context, String payment) async {
  //   try {
  //     showLoaderDialog(context);
  //     double totalPrice = 0.0;
  //     for (var element in list) {
  //       totalPrice += element.price * element.quantity!;
  //     }
  //     DocumentReference documentReference = _firebaseFirestore
  //         .collection("usersOrders")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection("orders")
  //         .doc();

  //     DocumentReference admin = _firebaseFirestore.collection("orders").doc();

  //     admin.set({
  //       "products": list.map((e) => e.toJson()),
  //       "status": "Pending",
  //       "totalPrice": totalPrice,
  //       "payment": payment,
  //       "orderid": admin.id
  //     });

  //     documentReference.set({
  //       "products": list.map((e) => e.toJson()),
  //       "status": "Pending",
  //       "totalPrice": totalPrice,
  //       "payment": payment,
  //       "orderid": documentReference.id
  //     });
  //     Navigator.of(context, rootNavigator: true).pop();
  //     showMessage("Ordered Successfully");

  //     return true;
  //   } catch (e) {
  //     showMessage(e.toString());
  //     Navigator.of(context, rootNavigator: true).pop();
  //     return false;
  //   }
  // }

  // // Get orders User

  // Future<List<OrderModel>> getUserOrder() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await _firebaseFirestore
  //             .collection("usersOrders")
  //             .doc(FirebaseAuth.instance.currentUser!.uid)
  //             .collection("orders")
  //             .get();

  //     List<OrderModel> orderList = querySnapshot.docs
  //         .map((element) => OrderModel.fromJson(element.data()))
  //         .toList();

  //     return orderList;
  //   } catch (e) {
  //     return [];
  //   }
  // }

  // void updateTokenFromFirebase() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   if (token != null) {
  //     await _firebaseFirestore
  //         .collection("users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .update({
  //       "notificationToken": token,
  //     });
  //   }
  // }
}
