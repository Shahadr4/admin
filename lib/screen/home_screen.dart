

import 'package:ev_admin/provider/catogory_provider.dart';
import 'package:ev_admin/provider/oder_provider.dart';
import 'package:ev_admin/provider/product_provider.dart';
import 'package:ev_admin/provider/user_provider.dart';
import 'package:ev_admin/screen/categoryList.dart';
import 'package:ev_admin/screen/productAdding.dart';
import 'package:ev_admin/screen/add_category.dart';
import 'package:ev_admin/screen/product_list.dart';
import 'package:ev_admin/screen/product_sold.dart';
import 'package:ev_admin/screen/users_list.dart';
import 'package:ev_admin/services/category_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper2/image_cropper2.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
 

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: TextButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text('Dashboard'))),
              Expanded(
                  child: TextButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                            _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Manage'))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white, 
        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {

    
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
     final orderProvider = Provider.of<OrdersProvider>(context);
      
     
 
    
        
    switch (_selectedPage) {
    
      
      case Page.dashboard:  
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: TextButton.icon(
                onPressed: null,
                icon: const Icon(
                  Icons.attach_money,
                  size: 30.0,
                  color: Colors.green, 
                ),
                label:  Text('${orderProvider.totalrevenue.toString()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: Colors.green)),
              ),
              title: const Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.grey),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserList(),)); 
                      },
                      child: Card(
                        child: ListTile(
                            title: TextButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.people_outline),
                                label: Text("Users")),
                            subtitle: Text(
                              '${userProvider.userList.length}', 
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 60.0),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0), 
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryList(),)); 
                      },
                      child: Card(
                        child: ListTile(
                            title: TextButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.category),
                                label: Text("Categories")),
                            subtitle: Text( 
                             '${categoryProvider.categoriesList.length}', 
                    
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 60.0),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0), 
                    child: GestureDetector(  
                      onTap:  () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList(),));
                              },
                      child: Card( 
                        child: ListTile(
                            title: TextButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.track_changes),
                                label: Text("Products")),
                            subtitle: Text( 
                              '${productProvider. productList.length }',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 60.0),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductSoldList(),)); 
                      },
                      child: Card(
                        child: ListTile(
                            title: TextButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.tag_faces),
                                label: Text("Sold")),
                            subtitle: Text(
                               '${orderProvider.orders.length }', 
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 60.0),
                            )),
                      ),
                    ),
                  ),
                 
                ],
              ),
            ),
          ],
        );
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading:const Icon(Icons.add),
              title:const Text("Add product"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductAdding(),)); 
              },
            ),
           const Divider(),
            ListTile(
              leading:const Icon(Icons.change_history),
              title:const Text("Products list"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList(),)); 
              },
            ),
           const Divider(),
            ListTile(
              leading:const Icon(Icons.add_circle),
              title:const Text("Add category"),
              onTap: () {
               // _categoryAlert();
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategories(),)); 
              },
            ),
           const Divider(),
            ListTile(
              leading:const Icon(Icons.category),
              title:const Text("Category list"),
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryList(),)); 
              },
            ),
           const Divider(),
          ],
        );
      default:
        return Container();
    }
  }

}