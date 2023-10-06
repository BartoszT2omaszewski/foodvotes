import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/add_opinion/cubit/add_opinion_cubit.dart';

import 'widgets/opinion_text_field.dart';

class AddOpinionPageContent extends StatelessWidget {
  const AddOpinionPageContent({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  final Function onSave;

  AddOpinionCubit _addOpinionCubit(BuildContext context) => context.read<AddOpinionCubit>();
  static const spaceBetweenFields = 10.0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AddOpinionCubit()..init(),
      child: BlocBuilder<AddOpinionCubit, AddOpinionState>(
        builder: (context, state) {
          return Center(
            child: Container(
              width: screenSize.width,
              height: screenSize.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8),
                    BlendMode.dstATop,
                  ),
                  image: const AssetImage('images/tlo.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Dodaj swoją opinie:',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              OpinionTextField(
                                hintText: 'Podaj nazwę restauracji',
                                onChanged: (restaurantName) =>
                                    _addOpinionCubit(context).setRestaurantName(restaurantName),
                              ),
                              const SizedBox(height: spaceBetweenFields),
                              OpinionTextField(
                                hintText: 'Podaj nazwę dania',
                                onChanged: (dishName) => _addOpinionCubit(context).setDishName(dishName),
                              ),
                              const SizedBox(height: spaceBetweenFields),
                              OpinionTextField(
                                hintText: 'Lokalizacja',
                                onChanged: (location) => _addOpinionCubit(context).setLocation(location),
                              ),
                              const SizedBox(height: spaceBetweenFields),
                              OpinionTextField(
                                hintText: 'Opis',
                                onChanged: (description) => _addOpinionCubit(context).setDescription(description),
                              ),
                              const SizedBox(height: spaceBetweenFields),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Slider(
                      onChanged: (rating) => _addOpinionCubit(context).setRating(rating),
                      value: state.rating,
                      min: 1.0,
                      max: 6.0,
                      divisions: 10,
                      label: state.rating.toString(),
                    ),
                    ElevatedButton(
                      onPressed: state.restaurantName.isEmpty ||
                              state.pizzaName.isEmpty ||
                              state.location.isEmpty ||
                              state.description.isEmpty
                          ? null
                          : () {
                              _addOpinionCubit(context).addNewOpinion();
                              onSave();
                            },
                      child: const Text('Dodaj'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
