import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  TextWidget({Key? key, required this.placeholder, required this.text, required this.controller})
      : super(key: key);

  String text;
  String placeholder;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
        ),
        onChanged: (_) {},
      ),
    );
  }
}
