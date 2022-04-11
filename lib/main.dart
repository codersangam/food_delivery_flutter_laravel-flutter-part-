import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/screens/product_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Devlivery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductDetailsScreen(),
    );
  }
}
