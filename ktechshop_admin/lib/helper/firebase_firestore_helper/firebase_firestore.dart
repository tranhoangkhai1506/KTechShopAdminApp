// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ktechshopadmin/constants/constants.dart';
import 'package:ktechshopadmin/models/categories_model/categories_model.dart';
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
