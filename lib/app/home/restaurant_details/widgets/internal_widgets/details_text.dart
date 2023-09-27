import 'package:flutter/material.dart';

class DetailsText extends StatelessWidget {
  const DetailsText({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 26),
    );
  }
}
