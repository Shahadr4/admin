
import 'package:ev_admin/provider/user_provider.dart';
import 'package:ev_admin/widget/listCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
            child: Text(
          'Users  List      ',
          style: GoogleFonts.sansita( 
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 40,

          ),
        )),
      ),
      body: ListView.builder(
        itemCount: userProvider.userList.length,
        itemBuilder:(context, index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              
              
               decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 215, 213, 213),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color.fromARGB(255, 13, 13, 13))),
          
          
                            child: ListCard(title: "${userProvider.userList[index].name}",image: "${userProvider.userList[index].image}",),

              ),
          ); 
        },
        
      ),
    
    );
  }
}
