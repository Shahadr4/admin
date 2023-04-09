

import 'package:ev_admin/const/fonts.dart';
import 'package:ev_admin/provider/oder_provider.dart';
import 'package:ev_admin/widget/odered_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

    


class ProductSoldList extends StatelessWidget {
  const ProductSoldList({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrdersProvider>(context);
    return   Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
            child: Text(
          'MY ORDERS',
          style: GoogleFonts.eczar(
            color: Color.fromARGB(255, 34, 33, 33),
            fontSize: 40,
          ),
        )),
      ),

      body:ListView.builder(
          itemCount: orderProvider.orders.length , 
          itemBuilder: (context, index) {

                
        DateTime createdAt = orderProvider.orders[index].createdAt.toDate();
        String formattedDate =DateFormat('dd-MM-yyyy  HH:mm:ss  ').format(createdAt); 
   

            return Padding(
              padding: const EdgeInsets.all(13),
              child: Container(
                
                height: MediaQuery.of(context).size.height*0.45,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),  
                   borderRadius: BorderRadius.circular(8), 
                   border: Border.all(
                    color: Color.fromARGB(255, 248, 248, 247)
                   )

                ),
                child: Column(
                  children: [
                    Text("Date And Time :${formattedDate} ",style: tHeading3 ,), 
                    Container(
                      color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly  ,
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [

                          Text("PRODUCT NAME "),
                          Text("PRODUCT SIZE "), 
                          Text('PRICE '),


                        ],
                      ),
                    ),
                      Container(
                      color: Colors.black26,
                      height: 150,
                      child:ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: orderProvider.orders[index].number,
                         itemBuilder: (context, index1) => Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row( 
                            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 120 ,
                                child: Text('${orderProvider.orders[index].carted[index1]['name'] }')),
                              Text("${orderProvider.orders[index].carted[index1]['size']   }"),
                              Text("${orderProvider.orders[index].carted[index1]['price']  }")   
                             
                                               
                              
                            ],
                                                 ),
                         ),
                      )
                      
                    ),
                    Divider(), 

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                       children: [
                        Text("Total amount "),
                        Text("${orderProvider.orders[index].price}")
                      ],
                    ),
                  ),
                  Divider(),
                  Text("Adress Details  ",style: tHeading2 ,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                    children: [
                      Text("Name :${orderProvider.orders[index].name}"),
                      Text("Phone Number:${orderProvider.orders[index].phone}")  
                    ],
                  ),
                  Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly , 
                    children:  [
                    Text("House Name :${orderProvider.orders[index].housename} "),
                    Text("pin : ${orderProvider.orders[index].pin}")

                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                    children:  [
                    Text("City:${orderProvider.orders[index].city} "),
                    Text("State: ${orderProvider.orders[index].state}")

                  ],),
                

                  ],
                ),
                
              ),
            );

          },



      )
    );
  }
}