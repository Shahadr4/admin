
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String name;
 String phone;
 String email;
 String image;

 UserModel({
  required this.name,
  required this.email,
  required this.phone,
  required this.image,
 }); 

  factory UserModel.fromFirestore(DocumentSnapshot data) {
    return UserModel(
      name: data['name'] ?? '',
      image: data['imageUrl'] ?? '',
      email: data['email']??"",
      phone: data['phone'] ?? '',

       
    );
  }







}