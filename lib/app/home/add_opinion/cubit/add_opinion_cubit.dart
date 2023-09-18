import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/add_opinion/add_opinion_page_content.dart';

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
