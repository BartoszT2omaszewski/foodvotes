import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  const TextWidget({
    required this.title,
    required this.fontSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          color: Colors.white54,
        ),
      ),
    );
  }
}
