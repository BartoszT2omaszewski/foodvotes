import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_opinion_state.dart';

class AddOpinionCubit extends Cubit<AddOpinionState> {
  AddOpinionCubit() : super(const AddOpinionState());

  void init() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        emit(AddOpinionState(userId: user.uid));
      }
    });
  }

  void setDishName(String dishName) {
    emit(AddOpinionState(
      pizzaName: dishName,
      restaurantName: state.restaurantName,
      rating: state.rating,
      location: state.location,
      description: state.description,
    ));
  }

  void setRestaurantName(String restaurantName) {
    emit(AddOpinionState(
      pizzaName: state.pizzaName,
      restaurantName: restaurantName,
      rating: state.rating,
      location: state.location,
      description: state.description,
    ));
  }

  void setRating(double rating) {
    emit(AddOpinionState(
      pizzaName: state.pizzaName,
      restaurantName: state.restaurantName,
      rating: rating,
      location: state.location,
      description: state.description,
    ));
  }

  void setLocation(String location) {
    emit(AddOpinionState(
      pizzaName: state.pizzaName,
      restaurantName: state.restaurantName,
      rating: state.rating,
      location: location,
      description: state.description,
    ));
  }

  void setDescription(String description) {
    emit(AddOpinionState(
      pizzaName: state.pizzaName,
      restaurantName: state.restaurantName,
      rating: state.rating,
      location: state.location,
      description: description,
    ));
  }

  void addNewOpinion() {
    FirebaseFirestore.instance.collection('restaurants').add({
      'name': state.restaurantName,
      'pizza': state.pizzaName,
      'rating': state.rating,
      'location': state.location,
      'description': state.description,
    });
  }
}
