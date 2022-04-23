import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/colors.dart';
import 'package:food_delivery_laravel/controllers/auth_controller.dart';
import 'package:food_delivery_laravel/models/user_model.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();

    void _registration() {
      var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        Get.snackbar('Error', 'name field is mandatory');
      } else if (phone.isEmpty) {
        Get.snackbar('Error', 'phone field is mandatory');
      } else if (!GetUtils.isEmail(email)) {
        Get.snackbar('Error', 'email address is not valid.');
      } else if (password.isEmpty) {
        Get.snackbar('Error', 'password field is mandatory.');
      } else if (password.length < 6) {
        Get.snackbar(
            'Error', 'password length should be greater than 6 characters');
      } else {
        UserModel userModel = UserModel(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );

        authController.registration(userModel).then((status) {
          if (status.isSuccess) {
            print('Registration Successful');
          } else {
            Get.snackbar('Error', status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            120.heightBox,
            VxCircle(
              radius: 100,
              backgroundColor: Colors.white,
              backgroundImage: const DecorationImage(
                image: AssetImage('assets/images/logopart1.png'),
                fit: BoxFit.cover,
              ),
            ).centered(),
            50.heightBox,
            CustomTextField(
              controller: emailController,
              isPassword: false,
              icon: Icons.email,
              title: 'Email',
              textInputType: TextInputType.emailAddress,
            ),
            20.heightBox,
            CustomTextField(
              controller: passwordController,
              isPassword: true,
              icon: Icons.lock,
              title: 'Password',
              textInputType: TextInputType.text,
            ),
            20.heightBox,
            CustomTextField(
              controller: nameController,
              isPassword: false,
              icon: Icons.person,
              title: 'Name',
              textInputType: TextInputType.name,
            ),
            20.heightBox,
            CustomTextField(
              controller: phoneController,
              isPassword: false,
              icon: Icons.phone,
              title: 'Phone',
              textInputType: TextInputType.phone,
            ),
            50.heightBox,
            GestureDetector(
              onTap: () => _registration(),
              child: VxBox(
                child: 'Register'.text.white.xl.makeCentered(),
              )
                  .make()
                  .backgroundColor(primaryColor)
                  .cornerRadius(30)
                  .wh(120, 60),
            ),
            10.heightBox,
            RichText(
              text: TextSpan(
                  text: 'Already have an account?',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[500],
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.back(),
                      text: 'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

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
