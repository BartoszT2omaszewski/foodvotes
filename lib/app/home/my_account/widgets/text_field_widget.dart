import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;

  const TextFieldWidget({
    Key? key,
    required this.title,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white54,
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white54,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white54,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              hintText: title,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white54,
              ),
            ),
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
