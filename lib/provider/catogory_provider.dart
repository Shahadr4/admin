import 'package:ev_admin/services/category_service.dart';
import 'package:flutter/material.dart';

import '../model/category_model.dart';

class CategoryProvider extends ChangeNotifier{
final CategoryServices categoryServices = CategoryServices();

   List<CatogoryName>categoriesList=[];

   CategoryProvider.initialize(){
    loadProduct();
   }

   loadProduct()async{
    categoriesList= await categoryServices.getCategories();
    notifyListeners(); 



   }

    addCategory(CatogoryName category) async {
    await categoryServices.createCategory(category);
    loadProduct();
  }




}