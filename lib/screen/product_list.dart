
import 'package:ev_admin/provider/product_provider.dart';
import 'package:ev_admin/widget/listCard.dart';
import 'package:ev_admin/widget/productCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
            child: Text(
          'Products List ',
          style: GoogleFonts.sansita( 
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 40,

          ),
        )),
      ),
      body: ListView.builder(
        itemCount: productProvider.productList.length,
        itemBuilder:(context, index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              
              
               decoration: BoxDecoration( 
                                color: const Color.fromARGB(255, 215, 213, 213),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color.fromARGB(255, 13, 13, 13))),
              
          
              child: ProductCard(title: "${productProvider.productList[index].productName}",image: "${productProvider.productList[index].productImage}",press:  () =>
                                  Provider.of<ProductProvider>(context, listen: false)
                                      .removeProduct(productProvider.productList[index].productName,index), 
              
              ),
          )); 
        },
        
      ),
    
    );
  }
}
