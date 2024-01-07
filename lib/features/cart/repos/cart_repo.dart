import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user/features/cart/models/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartRepo {
  static Future<List<CartModel>?> fetchUserCart() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
          .get();
      List<CartModel> cartModels = [];
      for (int i = 0; i < snapshot['cartList'].length; i++) {
        cartModels.add(CartModel(
            productId: snapshot['cartList'][i]['productId'],
            quantity: snapshot['cartList'][i]['quantity']));
      }
      return cartModels;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
