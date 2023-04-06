
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  String title,image;
  VoidCallback press;
   ProductCard({
    super.key,
    required this.title,
    required this.image,
    required this.press
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile( 
          title : Center(child: Text(title)),  
         leading  : Image.network(image),
          trailing: IconButton(
                              icon: const Icon(
                                Icons.cancel_rounded,
                                color: Colors.red,
                              ),
                              onPressed:press ,
                            ),
          ),
    );
  }
}