import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_admin/model/oders_model.dart';

class OrdersServices{
  CollectionReference firbase = FirebaseFirestore.instance.collection("oders");




Future<List<OderModel>> getOrders() async {   
  final FirebaseFirestore firestore = FirebaseFirestore.instance; 
  QuerySnapshot<Map<String, dynamic>> snapshot =
      await firestore.collection("oders").get(); 

  List<OderModel> orders = snapshot.docs
      .map((doc) => OderModel.fromFirestore(doc))
      .toList();

  return orders; 
} 
Future<double> getTotal() async {   
  final FirebaseFirestore firestore = FirebaseFirestore.instance; 
  QuerySnapshot<Map<String, dynamic>> snapshot =
      await firestore.collection("oders").get(); 

  List<OderModel> orders = snapshot.docs
      .map((doc) => OderModel.fromFirestore(doc))
      .toList();

      
  // Calculate the total price
  double totalPrice = 0.0;
  orders.forEach((order) {
    totalPrice +=  double.parse(order.price);
  });



  return totalPrice; 
} 



}