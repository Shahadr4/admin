
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_admin/model/productamodel.dart';
import 'package:ev_admin/services/product.dart';

import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier{
final ProductServices productServices = ProductServices();

   List<ProductModel>productList=[];

   ProductProvider.initialize(){
    loadProduct();
   }

   loadProduct()async{   
    productList=await productServices.getProducct();

    
    notifyListeners(); 



   }

    addproduct(ProductModel product) async {
    await productServices.createProductList(product);
    loadProduct();
  }



   Future<void> removeProduct(String productId,int index) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .delete();  

          productList.removeAt(index);

      // Notify listeners that the product has been removed
      notifyListeners();
    } catch (error) {
      // Handle any errors that occur during the deletion process
      print('Error deleting product: $error');
      throw error;
    }
  }

  





}