import 'package:flutter/material.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/restaurant_details/widgets/internal_widgets/details_text.dart';

class NameAndRatingDisplay extends StatelessWidget {
  const NameAndRatingDisplay({
    Key? key,
    required this.name,
    required this.rating,
  }) : super(key: key);

  final String name;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: DetailsText(text: name),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Ocena:',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  rating.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
