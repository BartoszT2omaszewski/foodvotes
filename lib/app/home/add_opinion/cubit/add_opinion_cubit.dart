import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_opinion_state.dart';

class AddOpinionCubit extends Cubit<AddOpinionState> {
  AddOpinionCubit()
      : super(const AddOpinionState(
          pizzaName: '',
          restaurantName: '',
          rating: 0,
          location: '',
          description: '',
        ));
}
