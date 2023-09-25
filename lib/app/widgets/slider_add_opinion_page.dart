import 'package:flutter/material.dart';

class NoTickMarkShape extends SliderTickMarkShape {
  @override
  Size getPreferredSize({required SliderThemeData sliderTheme, required bool isEnabled}) {
    return Size.zero;
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    required bool isEnabled,
    required TextDirection textDirection,
  }) {
    // Nie rysuj nic
  }
}

class SliderAddOpinionPage extends StatefulWidget {
  final String labelText;
  const SliderAddOpinionPage({Key? key, required this.labelText}) : super(key: key);

  @override
  State<SliderAddOpinionPage> createState() => _SliderAddOpinionPageState();
}

var rating = 3.0;

class _SliderAddOpinionPageState extends State<SliderAddOpinionPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            widget.labelText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 10.0,
              activeTrackColor: Colors.black,
              inactiveTrackColor: Colors.grey,
              tickMarkShape: NoTickMarkShape(),
              thumbColor: Colors.white,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
              overlayColor: Colors.white.withOpacity(0.2),
            ),
            child: Slider(
              onChanged: (newValue) {
                setState(() {
                  rating = newValue;
                });
              },
              value: rating,
              min: 1.0,
              max: 10.0,
              divisions: 9,
              label: rating.toString(),
            ),
          ),
        ),
      ],
    );
  }
}
