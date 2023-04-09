import 'package:ev_admin/model/oders_model.dart';
import 'package:ev_admin/services/order_services.dart';
import 'package:flutter/material.dart';

class OrdersProvider extends ChangeNotifier{
  final OrdersServices ordersServices=OrdersServices();

  OrdersProvider.initialize(){
    loadOrder();
  }


   List<OderModel>orders=[];

   double totalrevenue = 0.0;
   loadOrder()async{
   orders = await ordersServices.getOrders();
   totalrevenue = await ordersServices.getTotal(); 
   notifyListeners();

   }







}