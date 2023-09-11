import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user/features/products/models/product_model.dart';

class ProductsRepo{
  static Future<List<ProductModel>> getProducts()async{ 
   QuerySnapshot snapshot =  await FirebaseFirestore.instance.collection('products').get();
   final docs = snapshot.docs;
   List<ProductModel> products = [];
   for(int i = 0; i< docs.length; i++){ 
    products.add(ProductModel(name: docs[i]['name'], price: docs[i]['price'], description: docs[i]['description'], status: docs[i]['status']) );
   }
   return products;
  }
}