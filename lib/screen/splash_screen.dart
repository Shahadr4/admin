

import 'package:ev_admin/screen/home_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> gotoLogin() async{
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((ctx) =>Admin() )));
  }
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gotoLogin(); 
  }
  
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: SafeArea(child: Center(
        child: Image.asset("asset/app_logo.png"),  
      )),
    );
  }
}