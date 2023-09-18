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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dodaj swoją opinie',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(
              height: 90,
            ),
            TextField(
              decoration:
                  const InputDecoration(hintText: 'Podaj nazwę restauracji'),
              onChanged: (newValue) {
                setState(() {
                  restaurantName = newValue;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Podaj nazwę dania'),
              onChanged: (newValue) {
                setState(() {
                  pizzaName = newValue;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Lokalizacja'),
              onChanged: (newValue) {
                setState(() {
                  location = newValue;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Opis'),
              onChanged: (newValue) {
                setState(() {
                  description = newValue;
                });
              },
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
                child: const Text('Dodaj'))
          ],
        ),
      ),
    );
  }
}
