import 'package:flutter/material.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/restaurant_details/widgets/details_app_bar.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/restaurant_details/widgets/location_info_display.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/restaurant_details/widgets/name_and_rating_display.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/restaurant_details/widgets/opinions_list_view_display.dart';

class RestaurantDetailsPage extends StatelessWidget {
  const RestaurantDetailsPage({
    Key? key,
    required this.name,
    required this.location,
    required this.description,
    required this.rating,
  }) : super(key: key);

  final String name;
  final String location;
  final String description;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DetailsAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NameAndRatingDisplay(name: name, rating: rating),
              LocationInfoDisplay(location: location),
              OpinionsListViewDisplay(description: description),
            ],
          ),
        ),
      ),
    );
  }
}
