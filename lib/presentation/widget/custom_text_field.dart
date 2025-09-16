import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText = "Enter your email",
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: hintText,
        filled: true,
        fillColor: Color(0xFFD9D9D940).withOpacity( .1),  // background like your screenshot
        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFD9D9D940), width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
