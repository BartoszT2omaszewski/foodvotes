class OpinionModel {
  final String userId;
  final double rating;
  final String restaurantName;
  final String pizzaName;
  final String location;
  final String description;

  OpinionModel({
    required this.userId,
    required this.pizzaName,
    required this.restaurantName,
    required this.rating,
    required this.location,
    required this.description,
  });
}
