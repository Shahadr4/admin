import 'package:ev_admin/model/userModel.dart';
import 'package:ev_admin/services/user_services.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  final UserServices userServices = UserServices();

   List<UserModel>userList=[];

   UserProvider.initialize(){
    loadProduct();
   }

   loadProduct()async{   
    userList=await userServices.getUsers();

    
    notifyListeners(); 



   }

}