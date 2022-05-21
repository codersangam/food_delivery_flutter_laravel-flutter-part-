import 'package:flutter/material.dart';

class CartHistoryScreen extends StatefulWidget {
  const CartHistoryScreen({Key? key}) : super(key: key);

  @override
  State<CartHistoryScreen> createState() => _CartHistoryScreenState();
}

class _CartHistoryScreenState extends State<CartHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('cart history'),
      ),
    );
  }
}
