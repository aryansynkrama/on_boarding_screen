import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuildTextFormField extends StatelessWidget {
  const BuildTextFormField({
    super.key,
    required this.screenHeight,
    required this.labelText,
    required this.prefixIcon,
    this.validator,
    this.controller,
    this.suffixIcon,
    required this.obscureText,
    this.contentPadding, required this.horizontal, required this.vertical,
  });

  final double screenHeight;
  final String? labelText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool obscureText;
  final EdgeInsetsGeometry? contentPadding;
  final double horizontal;
  final double vertical;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,

      padding: EdgeInsets.symmetric(horizontal: horizontal,vertical: vertical),
      // height: screenHeight * 0.1,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(15),
      // ),
      child: TextFormField(


        // cursorHeight: 100,
        controller: controller,
        obscureText: obscureText,


        decoration: InputDecoration(

errorMaxLines: 1,

          errorStyle: const TextStyle(fontSize: 12,height: 0.4),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17.5),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17.5),
            borderSide: BorderSide(color: Colors.white),
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17.5),
          ),
          labelText: labelText,
          prefixIcon: Icon(prefixIcon, color: Colors.black54),
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 1 ),
        ),
        validator: validator,
      ),
    );
  }
}
