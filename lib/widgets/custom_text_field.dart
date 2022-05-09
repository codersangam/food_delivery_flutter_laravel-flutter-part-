import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.title,
    required this.isPassword,
    required this.textInputType,
  }) : super(key: key);

  final TextEditingController controller;
  final IconData icon;
  final String title;
  final bool isPassword;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: const Offset(1, 10),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: TextField(
        keyboardType: textInputType,
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: title,
          prefixIcon: Icon(
            icon,
            color: Colors.yellow,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
