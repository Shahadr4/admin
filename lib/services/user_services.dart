import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_admin/model/userModel.dart';

class UserServices{
  CollectionReference firbase = FirebaseFirestore.instance.collection("users");

   Future<List<UserModel>> getUsers() async {
    return firbase.get().then((value) {
      List<UserModel> userLIst = [];
      for (DocumentSnapshot users in value.docs) {
        userLIst.add(UserModel.fromFirestore(users));
      }
      return userLIst;
    });
  }


}