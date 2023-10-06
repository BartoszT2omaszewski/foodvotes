import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  String? userId;

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
    final screenSize = MediaQuery.of(context).size;
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
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                              hintText: 'Podaj nazwę restauracji',
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                restaurantName = newValue;
                              });
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
              ),
              const SizedBox(
                height: 10,
              ),
              Slider(
                onChanged: (newValue) {
                  setState(() {
                    rating = newValue;
                  });
                },
                value: rating,
                min: 1.0,
                max: 6.0,
                divisions: 10,
                label: rating.toString(),
              ),
              ElevatedButton(
                onPressed: restaurantName.isEmpty ||
                        pizzaName.isEmpty ||
                        location.isEmpty ||
                        description.isEmpty
                    ? null
                    : () {
                        FirebaseFirestore.instance
                            .collection('restaurants')
                            .add({
                          'name': restaurantName,
                          'pizza': pizzaName,
                          'rating': rating,
                          'location': location,
                          'description': description,
                        });
                        widget.onSave();
                      },
                child: const Text('Dodaj'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
