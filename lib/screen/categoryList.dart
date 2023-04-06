import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/catogory_provider.dart';
import '../widget/listCard.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
            child: Text(
          'Categories List ',
          style: GoogleFonts.sansita( 
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 40,

          ),
        )),
      ),
      body: ListView.builder(
        itemCount: categoryProvider.categoriesList.length,
        itemBuilder:(context, index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              
              
               decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 215, 213, 213),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color.fromARGB(255, 13, 13, 13))),
          
          
              child: ListCard(title: "${categoryProvider.categoriesList[index].title}",image: "${categoryProvider.categoriesList[index].image}",),
              
              ),
          ); 
        },
        
      ),
    
    );
  }
}
