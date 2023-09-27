import 'package:flutter/material.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/restaurant_details/widgets/internal_widgets/details_text.dart';

class OpinionsListViewDisplay extends StatelessWidget {
  const OpinionsListViewDisplay({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 2,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white), borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DetailsText(text: description),
            ],
          ),
        ],
      ),
    );
  }
}
