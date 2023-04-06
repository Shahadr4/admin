


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_admin/const/color.dart';
import 'package:ev_admin/model/productamodel.dart';
import 'package:ev_admin/provider/product_provider.dart';
import 'package:ev_admin/services/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper2/image_cropper2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/catogory_provider.dart';

class ProductAdding extends StatefulWidget {
  const ProductAdding({super.key});

  @override
  State<ProductAdding> createState() => _ProductAddingState();
}

class _ProductAddingState extends State<ProductAdding> {
  final picker = ImagePicker();
  File? imageFile;
  String? imgUrl;
  bool isSubmitting = false;
  final nameController = TextEditingController();
  final productDescription = TextEditingController();
  final productPrice = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();


  // ignore: prefer_typing_uninitialized_variables
  var selected;

  // ignore: prefer_typing_uninitialized_variables
  var  selectedGender;
   // ignore: non_constant_identifier_names
  List<String>Genders=[
    "Men",
    "Women",
   
  ];

//getfromcamera
  void getFromGallery() async {
    XFile? pickFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    cropImage(pickFile!.path);
    // ignore: use_build_context_synchronously
    // Navigator.pop(context);
  }


  //cropImage

  void cropImage(filepath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filepath,
    );

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  // error message to user
  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 500),
        behavior: SnackBarBehavior.floating,
        content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    // var selected= categoryProvider.categoriesList.isNotEmpty ? categoryProvider.categoriesList.first.title : null;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
            child: Text(
          'Add Products',
          style: GoogleFonts.sansita(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 40,
          ),
        )),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(

                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black
                          )
              
                        ),
                          child: GestureDetector(
                            onTap: () {
                              getFromGallery();
                            },
                            child: Container(
                                height: 200,
                                width: 200,
                                decoration: imageFile == null
                                    ? const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage("asset/OIP.jpg"),
                                            fit: BoxFit.contain))
                                    : BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.file(imageFile!).image),
                                      )),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Value is Empty';
                            } else if (value.length < 4) {
                              return 'Name too short';
                            }
                             if (value[0] != value[0].toUpperCase()) {
                                return 'category must start with a capital letter';
                              }  else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 6, 6, 6)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: tButtonColor)),
                            label: const Text("Product Name "),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                          const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                         controller: productDescription, 
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Value is Empty';
                            } else if (value.length < 4) {
                              return 'Name too short';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 6, 6, 6)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: tButtonColor)),
                            label: const Text(" Product Discription  "),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      
                        
                        const SizedBox(
                          height: 30,
                        ),
                        Row( 
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100, 
                               
                              child: TextFormField(
                                controller: productPrice,
                                                validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Value is Empty';
                              } else {
                                return null;
                              }
                                                },
                            
                                                keyboardType: TextInputType.number,
                                                //  controller: _pinController,
                                                decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 6, 6, 6)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: tButtonColor)),
                              label: const Text("Product Price "),
                              border: const OutlineInputBorder(),
                                                ),
                                              ),
                            ), 
              
              
                            const Text("Categories : "),
                   
                   
                   
                   
                   
                   
                   
                           DropdownButton<String>(
                              items: categoryProvider.categoriesList
                                  .map((e) => DropdownMenuItem(
                                      value: e.title, child: Text(e.title)))
                                  .toList(),
                              onChanged: (selectedCategory) {
                                setState(() {
                                  selected = selectedCategory;
                              
                                });
                              },
                              value: selected,
                              hint: const Text("Tap to select"),
                            ),
                          ],
                        ),
                         const SizedBox(
                          height: 30,
                        ), 
                        Row(
                          children: [
                            const Text("Gender:  "),
                            DropdownButton<String>(
                              items: Genders
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (selectedCategory) {
                                setState(() {
                                  selectedGender = selectedCategory;
                                  print(selectedCategory);
              
                              
                                });
                              },
                              value: selectedGender,
                              hint: const Text("Tap to select"),
                            ),
                          ],
                        ),
                          const SizedBox(
              
              
                          height: 30,
                        ),  
                        
               
                      
                         const SizedBox(
                          height: 30,
                        ), 
                         ElevatedButton(  
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.blue),
                          ),
                          onPressed:() async{
                             setState(() {
                            isSubmitting = true;
                          });
              
                            if(imageFile == null){ 
                                   setState(() {
                          isSubmitting = false;
                        }); 
                              showErrorMessage("please Select an Image");
                            }else {
                               if (formKey.currentState!.validate()) {
                              
                               
                             
                                if(selectedGender==null ){
                                       setState(() {
                          isSubmitting = false;
                        }); 
                                 showErrorMessage("please Select an Gender");
                              }else{
                                if(selected!=null){
                                  print("Upload");
              
                                  try{
                                    ProductServices productServices = ProductServices();
                                    final ref= FirebaseStorage.instance.ref().child('product').child("${nameController.text}.jpg");
                                    await ref.putFile(imageFile!);
                                    imgUrl = await ref.getDownloadURL();
                                    ProductModel productModel=ProductModel(productName: nameController.text, productDescription: productDescription.text, gender: selectedGender, price: double.parse(productPrice.text), productImage: imgUrl!, selected: selected,);
                                      await Provider.of<ProductProvider>(context, listen: false).addproduct(productModel);
                                   showErrorMessage("please Select an uploaded");        
                                     Navigator.pop(context);  
              
                                  }catch(e){
                                    print(e);
                                  }
                                 //                                                  
              
                                }else{
                                       setState(() {
                          isSubmitting = false;
                        }); 
                                    showErrorMessage("please Select an Categories"); 
              
                                }
                              }
                          
                             
                            }      setState(() {
                          isSubmitting = false;
                        }); 

                      
                            }
                          },
                          child: Text("Add  Product",style: TextStyle(
                            color: Colors.black 
                          ),),
                        )
              
                      ],
                    ),
                  ),
                  
                ),
              ),
             
              
              

            ],
          ),
           if (isSubmitting)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),  
        ],
      ),
       
      
      
    );
    
  }
  
} 