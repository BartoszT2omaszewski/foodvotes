import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddOpinionPageContent extends StatefulWidget {
  const AddOpinionPageContent({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  final Function onSave;

  @override
  State<AddOpinionPageContent> createState() => _AddOpinionPageContentState();
}

var rating = 3.0;
var restaurantName = '';
var pizzaName = '';
var location = '';
var description = '';

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Podaj nazwę restauracji',
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
                      FirebaseFirestore.instance.collection('restaurants').add({
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
    );
  }
}
