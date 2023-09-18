import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/opinie/votes_page_content.dart';

import 'add_opinion/add_opinion_page_content.dart';
import 'my_account/my_acconut_page_content.dart';
import 'restaurants/restaurants_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

var currentIdex = 0;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Votes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Builder(builder: (context) {
            if (currentIdex == 0) {
              return const RestaurantsPageContent();
            }
            if (currentIdex == 1) {
              return const VotesPageContent();
            }
            if (currentIdex == 2) {
              return AddOpinionPageContent(
                onSave: () {
                  setState(() {
                    currentIdex = 0;
                  });
                },
              );
            }
            return MyAccountPageContent(email: widget.user.email);
          }),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIdex,
        onTap: (newIndex) {
          setState(() {
            currentIdex = newIndex;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Szukaj',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Opinie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Dodaj Opinie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Moje konto',
          ),
        ],
      ),
    );
  }
}
