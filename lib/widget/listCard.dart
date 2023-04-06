
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  String title,image;
  
   ListCard({
    super.key,
    required this.title,
    required this.image,
  
    
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile( 
          leading : TextButton.icon(
              onPressed:null,
              icon: Icon(Icons.category),
              label: Text(title)),
         trailing : Image.network(image)
          ),
    );
  }
}
