

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_admin/model/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CategoryServices{
 CollectionReference firbase = FirebaseFirestore.instance.collection("categories");
  


  Future<void> createCategory(CatogoryName category) async {
    try {

      Map<String,dynamic>ctr={
        'title' : category.title,
      'image': category.image
      
        

      };

      await firbase.doc(category.title).set(ctr);
    } catch (e) {
      print(e);
      rethrow;
    }
  }



   Future<List<CatogoryName>> getCategories() async {
    return firbase.get().then((value) {
      List<CatogoryName> catogories = [];
      for (DocumentSnapshot category in value.docs) {
        catogories.add(CatogoryName.fromFirestore(category));
      }
      return catogories;
    });
  }
  
  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) =>
      firbase.where('category', isEqualTo: suggestion).get().then((snap){
        return snap.docs;
      }); 


     





 
}