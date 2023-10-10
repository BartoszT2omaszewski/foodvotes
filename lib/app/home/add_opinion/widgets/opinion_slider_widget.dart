import 'package:flutter/material.dart';

class OpinionSliderWidget extends StatelessWidget {
  const OpinionSliderWidget({
    Key? key,
    required this.spaceBetweenFields,
    required this.label,
    this.onChanged,
    required this.value,
  }) : super(key: key);

  final double spaceBetweenFields;
  final String label;
  final Function(double rating)? onChanged;
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: spaceBetweenFields * 0.5),
          Container(
            height: spaceBetweenFields * 5,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white), borderRadius: const BorderRadius.all(Radius.circular(16))),
            child: Slider(
              inactiveColor: const Color(0x9E0F0F0F),
              activeColor: const Color(0xFF0F0F0F),
              thumbColor: Colors.white,
              onChanged: onChanged,
              value: value,
              min: 1.0,
              max: 6.0,
              divisions: 10,
              label: value.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
