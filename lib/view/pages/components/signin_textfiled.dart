import 'package:flutter/material.dart';

class TextField_sign extends StatelessWidget {
  final String txt;
  final TextEditingController? controller;
  const TextField_sign({super.key, required this.txt, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            label: Text(txt),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
