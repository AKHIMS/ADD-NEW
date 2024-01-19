// ignore_for_file: unused_import, empty_statements, use_super_parameters
import 'package:contacts_list_app/home_page.dart';
import 'package:contacts_list_app/shoesui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoe List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ShoesUi(products: List.generate(10, (index) => Product.defaultProduct())),
    );
  }
}
