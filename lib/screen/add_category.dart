import 'dart:io';

import 'package:ev_admin/provider/catogory_provider.dart';
import 'package:ev_admin/services/category_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_cropper2/image_cropper2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/category_model.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  TextEditingController categoryController = TextEditingController();

  GlobalKey<FormState> _categoryFormKey = GlobalKey();

  final picker = ImagePicker();
  File? imageFile;
  String? imgUrl;
  bool isSubmitting = false;

  // BrandService _brandService = BrandService();
  //CategoryService _categoryService = CategoryService();

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
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
            child: Text(
          'Add Categories',
          style: GoogleFonts.sansita(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 40,
          ),
        )),
      ),
      body: Stack(
        children: [
          AlertDialog(
            content: Form(
              key: _categoryFormKey,
              child: SizedBox(
                height: 300,
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                            getFromGallery();
                          },
                          child: Container(
                              width: 100,
                              height: 100,
                              decoration: imageFile == null
                                  ? const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage("asset/OIP.jpg"),
                                          fit: BoxFit.contain))
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: Image.file(imageFile!).image),
                                    ))),
                    ),
                    const Divider(),
                    TextFormField(
                      controller: categoryController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'category cannot be empty';
                        }
                        if (value[0] != value[0].toUpperCase()) {
                          return 'category must start with a capital letter';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(hintText: "add category"),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    setState(() {
                      isSubmitting = true;
                    });

                    if (imageFile == null) {
                      showErrorMessage("please select your image");
                    } else {
                      if (_categoryFormKey.currentState!.validate()) {
                        try {
                          CategoryServices categoryServices =
                              CategoryServices();
                          final ref = FirebaseStorage.instance
                              .ref()
                              .child('category')
                              .child("${categoryController.text.trim()}.jpg");
                          await ref.putFile(imageFile!);
                          imgUrl = await ref.getDownloadURL();

                          CatogoryName newCategory = CatogoryName(
                              image: imgUrl!, title: categoryController.text);
                          await Provider.of<CategoryProvider>(context,
                                  listen: false)
                              .addCategory(newCategory);


                          showErrorMessage("Upload successfully");
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        } catch (e) {
                          showErrorMessage(e.toString());
                        }
                      }
                    }
                    setState(() {
                      isSubmitting = false;
                    });
                  },
                  child: const Text('ADD')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
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
