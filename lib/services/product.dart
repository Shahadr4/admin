import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_admin/model/productamodel.dart';

class ProductServices{

   CollectionReference firbase = FirebaseFirestore.instance.collection("products");


     Future<void> createProductList(ProductModel productModel) async {
    try {

      Map<String,dynamic>ctr={
        'title' : productModel.productName,
      'image': productModel.productImage,
      'description':productModel.productDescription,
      "price":productModel.price,
      'gender':productModel.gender,
      'categories':productModel.selected,
    
      'liked':false,
      
      
        

      };

      await firbase.doc(productModel.productName).set(ctr);
    } catch (e) {
      print(e);
      rethrow;
    }



  }
  
      Future<List<ProductModel>> getProducct() async {
    return firbase.get().then((value) { 
      List<ProductModel> product = [];
      for (DocumentSnapshot products in value.docs) {
        product.add(ProductModel.fromFirestore(products));
      }
      return product;
    });
  }






}