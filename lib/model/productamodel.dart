

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel extends ChangeNotifier{
  String productName;
  String productDescription;
  String productImage;
  double price;
  var selected;
  
  var gender;
   
  

  ProductModel({
    required this.productName,
    required this.productDescription,
    required this.gender,
    required this.price,
    required this.productImage,
    required this.selected,
    
     
  }); 
 


  factory ProductModel.fromFirestore(DocumentSnapshot data) {
    return ProductModel(
      productName: data['title'] ?? '',
      productImage: data['image'] ?? '',
      productDescription: data['description'] ?? "",
      price: (data['price'] ?? 0.0).toDouble(),
      gender: data['gender'] ?? "",
      selected: data['categories']?? "",
    
      
       
    );
  }









}