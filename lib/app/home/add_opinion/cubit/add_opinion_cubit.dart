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
      location: state.location,
      description: state.description,
    ));
  }

  void setRestaurantName(String restaurantName) {
    emit(AddOpinionState(
      pizzaName: state.pizzaName,
      restaurantName: restaurantName,
      location: state.location,
      description: state.description,
    ));
  }

  void setLocation(String location) {
    emit(AddOpinionState(
      pizzaName: state.pizzaName,
      restaurantName: state.restaurantName,
      location: location,
      description: state.description,
    ));
  }

  void setDescription(String description) {
    emit(AddOpinionState(
      pizzaName: state.pizzaName,
      restaurantName: state.restaurantName,
      location: state.location,
      description: description,
    ));
  }

  void setAppearanceValue(double rating) {
    emit(AddOpinionState(
      appearance: rating,
      service: state.service,
      atmosphere: state.atmosphere,
      prices: state.prices,
      quality: state.quality,
    ));
  }

  void setServiceValue(double rating) {
    emit(AddOpinionState(
      appearance: state.appearance,
      service: rating,
      atmosphere: state.atmosphere,
      prices: state.prices,
      quality: state.quality,
    ));
  }

  void setAtmosphereValue(double rating) {
    emit(AddOpinionState(
      appearance: state.appearance,
      service: state.service,
      atmosphere: rating,
      prices: state.prices,
      quality: state.quality,
    ));
  }

  void setPricesValue(double rating) {
    emit(AddOpinionState(
      appearance: state.appearance,
      service: state.service,
      atmosphere: state.atmosphere,
      prices: rating,
      quality: state.quality,
    ));
  }

  void setQualityValue(double rating) {
    emit(AddOpinionState(
      appearance: state.appearance,
      service: state.service,
      atmosphere: state.atmosphere,
      prices: state.prices,
      quality: rating,
    ));
  }

  void addNewOpinion() {
    FirebaseFirestore.instance.collection('restaurants').add({
      'name': state.restaurantName,
      'pizza': state.pizzaName,
      'location': state.location,
      'description': state.description,
      'appearance': state.appearance,
      'service': state.service,
      'atmosphere': state.atmosphere,
      'prices': state.prices,
      'quality': state.quality,
    });
  }
}
