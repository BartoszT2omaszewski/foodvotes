import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'restaurants_state.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantsCubit()
      : super(
          const RestaurantsState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  final controller = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = [];
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const RestaurantsState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('restaurants')
        .orderBy(
          'average',
          descending: true,
        )
        .snapshots()
        .listen((data) {
      emit(
        RestaurantsState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          RestaurantsState(
            documents: const [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  Future<void> updateData(String value) async {
    _streamSubscription = FirebaseFirestore.instance
        .collection('restaurants')
        .orderBy(
          'average',
          descending: true,
        )
        .snapshots()
        .listen((data) {
      emit(
        RestaurantsState(
          documents: data.docs.where((data) => data['name'].toLowerCase().contains(value.toLowerCase())).toList(),
          isLoading: false,
          errorMessage: '',
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
