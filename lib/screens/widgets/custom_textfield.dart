import 'package:flutter/material.dart';
import 'package:plant_dictionary/constants.dart';
class CustomTextfield extends StatelessWidget {
  final IconData icon;
  final bool obscureText;
  final String hintText;
  final TextEditingController? controller;

  const CustomTextfield({
    Key? key, 
    required this.icon, 
    required this.obscureText, 
    required this.hintText, 
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          color: Constants.blackColor,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Constants.blackColor.withOpacity(.3),),
          hintText: hintText,
        ),
        cursorColor: Constants.blackColor.withOpacity(.5),
      ),
    );
  }
}