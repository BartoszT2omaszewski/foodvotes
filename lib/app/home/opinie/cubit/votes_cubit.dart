import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:najlepsza_pizza_w_miescie/app/home/opinie/cubit/votes_state.dart';

class VotesCubit extends Cubit<VotesState> {
  VotesCubit()
      : super(
          const VotesState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _streamSubscription;
  String _currentSortOrder = 'rating';
  bool _isDescending = true;

  Future<void> start() async {
    _startListening();
  }

  void _startListening() {
    _streamSubscription?.cancel();

    emit(
      const VotesState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('restaurants')
        .orderBy(
          _currentSortOrder,
          descending: _isDescending,
        )
        .snapshots()
        .listen((data) {
      emit(
        VotesState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          VotesState(
            documents: const [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  void changeSorting(String newOrder) {
    if (newOrder == 'rating_desc') {
      _currentSortOrder = 'rating';
      _isDescending = true;
    } else {
      _currentSortOrder = 'rating';
      _isDescending = false;
    }
    _startListening();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
