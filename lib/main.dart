
import 'package:ev_admin/provider/catogory_provider.dart';
import 'package:ev_admin/provider/product_provider.dart';
import 'package:ev_admin/provider/user_provider.dart';
import 'package:ev_admin/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: 
    [
ChangeNotifierProvider.value(value: CategoryProvider.initialize()) ,
ChangeNotifierProvider.value(value: ProductProvider.initialize()) ,
ChangeNotifierProvider.value(value: UserProvider.initialize()) ,
    ],
    child:  MaterialApp(
      title: 'Flutter Demo', 
      
      debugShowCheckedModeBanner: false,  
      theme: ThemeData(
        
         
        primarySwatch: Colors.blue,
      ),
      home:SplashScreen(),
    ) ,
    );
    
    
    
    
  }
}
