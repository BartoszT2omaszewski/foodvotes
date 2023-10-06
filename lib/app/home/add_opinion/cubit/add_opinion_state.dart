part of 'add_opinion_cubit.dart';

@immutable
class AddOpinionState {
  const AddOpinionState({
    this.userId,
    this.pizzaName = '',
    this.restaurantName = '',
    this.rating = 3.0,
    this.location = '',
    this.description = '',
  });
  final String? userId;
  final double rating;
  final String restaurantName;
  final String pizzaName;
  final String location;
  final String description;
}
