import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najlepsza_pizza_w_miescie/app/model/opinion_model.dart';

part 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  MyAccountCubit()
      : super(const MyAccountState(
          errorMessage: '',
          isLoading: false,
          userOpinions: [],
        ));

  StreamSubscription? _streamSubscription;

  Future<void> start(String userId) async {
    _streamSubscription = FirebaseFirestore.instance
        .collection('restaurants')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .listen((items) {
      final opinionModels = items.docs.map((doc) {
        return OpinionModel(
          pizzaName: doc['pizza'],
          restaurantName: doc['name'],
          rating: doc['rating'] as double,
          location: doc['location'],
          description: doc['description'],
          userId: doc['userId'],
        );
      }).toList();
      emit(MyAccountState(
        isLoading: false,
        errorMessage: '',
        userOpinions: opinionModels,
      ));
    })
      ..onError((error) {
        emit(MyAccountState(
          isLoading: false,
          errorMessage: error.toString(),
          userOpinions: [],
        ));
      });
  }

  Future<void> updateUserName(String userId, String newName) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'name': newName,
      });
      MyAccountState currentState = state;

      MyAccountState updatedState = MyAccountState(
        isLoading: currentState.isLoading,
        errorMessage: currentState.errorMessage,
        userOpinions: currentState.userOpinions,
      );

      emit(updatedState);
    } catch (error) {
      error.toString();
    }
  }

  Future<String> getUserName(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      String userName = userDoc['name'] ?? '';

      return userName;
    } catch (error) {
      error.toString();

      return '';
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
