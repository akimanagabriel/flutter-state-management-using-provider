import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final TextEditingController controller;

  const CustomTextInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.black.withOpacity(.1),
        width: size.width * 0.8,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10),
            prefixIcon: icon,
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
