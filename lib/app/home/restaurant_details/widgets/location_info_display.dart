import 'package:flutter/material.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/restaurant_details/widgets/internal_widgets/details_text.dart';

class LocationInfoDisplay extends StatelessWidget {
  const LocationInfoDisplay({
    Key? key,
    required this.location,
  }) : super(key: key);

  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 3, child: DetailsText(text: 'Lokalizacja:')),
        Expanded(child: DetailsText(text: location)),
      ],
    );
  }
}
