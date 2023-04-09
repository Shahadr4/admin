import 'package:cloud_firestore/cloud_firestore.dart';
 

class OderModel {
  List<Map<String, dynamic>> carted;

  String price;
  String name;
  String uid;
  Timestamp createdAt;
  int number;
  String housename;
  String pin;
  String state;
  String phone;
  String city;

  OderModel({
    required this.carted,
    required this.price,
    required this.name,
    required this.uid,
    required this.createdAt,
    required this.number,
     required this.state,
      required this.city,
       required this.housename,
        required this.phone,
         required this.pin

  });

  factory OderModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> data) {
    return OderModel(
      carted: List<Map<String, dynamic>>.from(data.data()!['carted']),   
      price: data['price'],
      name: data['name'],
      uid: data['uid'],
      createdAt: data['create at'],
      number: data['number'],
      city: data['city'],
      housename:  data['houseName'],
      phone: data['phone'],
      pin: data['pin'],
      state: data['state'] 
    );
  }
}
