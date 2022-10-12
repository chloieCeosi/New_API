// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:q/screens/product/list_product_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/productModel.dart';
import '../services/auth_services.dart';
import '../services/product_services.dart';
import 'auth/login_screen.dart';
import 'product/add_product_screen.dart';
import 'product/single_product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences preferences;

  _SharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _SharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [
              PopupMenuButton(
                  icon: Icon(Icons.more_vert, color: Colors.black),
                  itemBuilder: (ctx) => [
                        PopupMenuItem(
                          onTap: () async {
                            // print(preferences.getString('token'));
                            // await preferences.remove('token');
                            // print(preferences.getString('token'));
                            await AuthServices.LogOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text('Log Out'),
                        )
                      ])
            ]),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            print(preferences.getString('token'));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProductScreen()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.black,
        ),
        body: Container(
            child: Column(children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Expanded(child: ListProductScreen())
        ])));
  }
}