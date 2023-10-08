part of 'add_opinion_cubit.dart';

@immutable
class AddOpinionState {
  const AddOpinionState({
    this.userId,
    this.pizzaName = '',
    this.restaurantName = '',
    this.location = '',
    this.description = '',
    this.appearance = 3.0,
    this.service = 3.0,
    this.atmosphere = 3.0,
    this.prices = 3.0,
    this.quality = 3.0,
  });
  final String? userId;
  final String restaurantName;
  final String pizzaName;
  final String location;
  final String description;

  final double appearance;
  final double service;
  final double atmosphere;
  final double prices;
  final double quality;

  bool get opinionValidator => restaurantName.isEmpty || pizzaName.isEmpty || location.isEmpty || description.isEmpty;
}
