import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user/features/products/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductsRepo {
  static Future<List<ProductModel>> getProducts() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    final docs = snapshot.docs;
    List<ProductModel> products = [];
    for (int i = 0; i < docs.length; i++) {
      products.add(ProductModel(
          id: docs[i].id,
          name: docs[i]['name'],
          price: docs[i]['price'],
          description: docs[i]['description'],
          status: docs[i]['status']));
    }
    return products;
  }

  static updateMyCart(String productId) async {
    User? currUser = FirebaseAuth.instance.currentUser;
    if (currUser != null) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(currUser.uid)
          .get();
      if (documentSnapshot.exists) {
        bool isProductFound = false;

        List cartList = documentSnapshot["cartList"] ?? [];
        for (int i = 0; i < cartList.length; i++) {
          if (cartList[i]['productId'] == productId) {
            int currentQuantity = cartList[i]['quantity'];
            cartList[i]['quantity'] = currentQuantity + 1;
            await FirebaseFirestore.instance
                .collection("users")
                .doc(currUser.uid)
                .update({"cartList": cartList});
            isProductFound = true;
            break;
          }
        }
        if (!isProductFound) {
          cartList.add({"productId": productId, "quantity": 1});
          await FirebaseFirestore.instance
              .collection("users")
              .doc(currUser.uid)
              .update({"cartList": cartList});
        }
      }
      log("Cart Updated");
    }
  }
}
