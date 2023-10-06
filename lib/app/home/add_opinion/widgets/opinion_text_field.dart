
import 'package:flutter/material.dart';

class OpinionTextField extends StatelessWidget {
  const OpinionTextField({
    Key? key,
    this.onChanged,
    required this.hintText,
  }) : super(key: key);

  final Function(dynamic value)? onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
        onChanged: onChanged);
  }
}
