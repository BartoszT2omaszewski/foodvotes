import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:najlepsza_pizza_w_miescie/app/widgets/slider_add_opinion_page.dart';

class AddOpinionPageContent extends StatefulWidget {
  const AddOpinionPageContent({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  final Function onSave;

  @override
  State<AddOpinionPageContent> createState() => _AddOpinionPageContentState();
}

var restaurantName = '';
var pizzaName = '';
var location = '';
var description = '';
double rating = 0.0;

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  String? userId;
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Dodaj swoją opinię:',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                          final restaurantsSnapshot = await FirebaseFirestore
                              .instance
                              .collection('restaurants')
                              .where('name', isGreaterThanOrEqualTo: pattern)
                              .get();
                          return restaurantsSnapshot.docs
                              .map((doc) => doc['name'].toString())
                              .toList();
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
                          FirebaseFirestore.instance
                              .collection('restaurants')
                              .add({
                            'name': restaurantNameController.text,
                            'pizza': pizzaName,
                            'rating': rating,
                            'location': location,
                            'description': description,
                            'userId': userId
                          });
                          widget.onSave();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Podaj nazwę dania',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            pizzaName = newValue;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Lokalizacja',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            location = newValue;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Opis',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            description = newValue;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SliderAddOpinionPage(
              labelText: 'Wygląd:',
            ),
            const SliderAddOpinionPage(
              labelText: 'Obsługa:',
            ),
            const SliderAddOpinionPage(
              labelText: 'Atmosfera:',
            ),
            const SliderAddOpinionPage(
              labelText: 'Cena:',
            ),
            const SliderAddOpinionPage(
              labelText: 'Jakość/Świeżość:',
            ),
            const SliderAddOpinionPage(
              labelText: 'Ogólna ocena:',
            ),
            ElevatedButton(
              onPressed: restaurantNameController.text.isEmpty ||
                      pizzaName.isEmpty ||
                      location.isEmpty ||
                      description.isEmpty ||
                      userId == null
                  ? null
                  : () {
                      FirebaseFirestore.instance.collection('restaurants').add({
                        'name': restaurantNameController.text,
                        'pizza': pizzaName,
                        'rating': rating,
                        'location': location,
                        'description': description,
                        'userId': userId
                      });
                      widget.onSave();
                    },
              child: const Text(
                'Dodaj',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
