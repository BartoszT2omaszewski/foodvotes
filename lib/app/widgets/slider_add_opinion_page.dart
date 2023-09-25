import 'package:flutter/material.dart';

class SliderAddOpinionPage extends StatefulWidget {
  const SliderAddOpinionPage({Key? key}) : super(key: key);

  @override
  State<SliderAddOpinionPage> createState() => _SliderAddOpinionPageState();
}

var rating = 3.0;

class _SliderAddOpinionPageState extends State<SliderAddOpinionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Slider(
        onChanged: (newValue) {
          setState(() {
            rating = newValue;
          });
        },
        value: rating,
        min: 1.0,
        max: 6.0,
        divisions: 10,
        label: rating.toString(),
      ),
    );
  }
}
