import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/add_opinion/cubit/add_opinion_cubit.dart';

import 'widgets/opinion_slider_widget.dart';
import 'widgets/opinion_text_field.dart';

class AddOpinionPageContent extends StatefulWidget {
  const AddOpinionPageContent({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  final Function onSave;

  @override
  State<AddOpinionPageContent> createState() => _AddOpinionPageContentState();
}

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  static const spaceBetweenFields = 10.0;
  String? userId;
  AddOpinionCubit _addOpinionCubit(BuildContext context) => context.read<AddOpinionCubit>();
  TextEditingController restaurantNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          userId = user.uid;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddOpinionCubit()..init(),
      child: BlocBuilder<AddOpinionCubit, AddOpinionState>(
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Dodaj swoją opinię',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  TypeAheadFormField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: restaurantNameController,
                      decoration: const InputDecoration(
                        hintText: 'Podaj nazwę restauracji',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      final restaurantsSnapshot = await FirebaseFirestore.instance
                          .collection('restaurants')
                          .where('name', isGreaterThanOrEqualTo: pattern)
                          .get();
                      return restaurantsSnapshot.docs.map((doc) => doc['name'].toString()).toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        restaurantNameController.text = suggestion;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nazwa restauracji jest wymagana';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      FirebaseFirestore.instance.collection('restaurants').add({
                        'name': restaurantNameController.text,
                        'pizza': state.dishName,
                        'rating': state.average,
                        'location': state.location,
                        'description': state.description,
                        'userId': userId
                      });
                      widget.onSave();
                    },
                  ),
                  const SizedBox(height: 30),
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
                  const SizedBox(height: spaceBetweenFields),
                  OpinionSliderWidget(
                    spaceBetweenFields: spaceBetweenFields,
                    label: 'Wygląd: ',
                    value: state.appearance,
                    onChanged: (rating) => _addOpinionCubit(context).setAppearanceValue(rating),
                  ),
                  const SizedBox(height: spaceBetweenFields),
                  OpinionSliderWidget(
                    spaceBetweenFields: spaceBetweenFields,
                    label: 'Obsługa: ',
                    value: state.service,
                    onChanged: (rating) => _addOpinionCubit(context).setServiceValue(rating),
                  ),
                  const SizedBox(height: spaceBetweenFields),
                  OpinionSliderWidget(
                    spaceBetweenFields: spaceBetweenFields,
                    label: 'Atmosfera: ',
                    value: state.atmosphere,
                    onChanged: (rating) => _addOpinionCubit(context).setAtmosphereValue(rating),
                  ),
                  const SizedBox(height: spaceBetweenFields),
                  OpinionSliderWidget(
                    spaceBetweenFields: spaceBetweenFields,
                    label: 'Cena: ',
                    value: state.prices,
                    onChanged: (rating) => _addOpinionCubit(context).setPricesValue(rating),
                  ),
                  const SizedBox(height: spaceBetweenFields),
                  OpinionSliderWidget(
                    spaceBetweenFields: spaceBetweenFields,
                    label: 'Jakość/świeżość: ',
                    value: state.quality,
                    onChanged: (rating) => _addOpinionCubit(context).setQualityValue(rating),
                  ),
                  const SizedBox(height: spaceBetweenFields),
                  ElevatedButton(
                    onPressed: state.opinionValidator
                        ? null
                        : () {
                            _addOpinionCubit(context).addNewOpinion();
                            widget.onSave();
                          },
                    child: const Text('Dodaj'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
