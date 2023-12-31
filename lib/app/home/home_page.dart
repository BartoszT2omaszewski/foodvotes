import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: Row(
          children: [
            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.white,
                  shadows: [
                    const Shadow(
                      offset: Offset(4.0, 4.0),
                      blurRadius: 2.0,
                      color: Colors.black,
                    ),
                  ],
                ),
                children: [
                  WidgetSpan(
                    child: Transform.translate(
                      offset: const Offset(53, -8),
                      child: Transform.rotate(
                        angle: 33.27 / 180.0,
                        child: Image.asset(
                          'images/Chef-Hat.jpg',
                          height: 45,
                          width: 45,
                        ),
                      ),
                    ),
                  ),
                  const TextSpan(
                    text: 'FoodVotes',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 3.0,
                      decorationColor: Color.fromARGB(255, 171, 221, 247),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        elevation: 1,
        backgroundColor: Colors.transparent,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            height: 2.0,
            thickness: 1.2,
          ),
        ),
      ),
      body: ListView(
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
            return MyAccountPageContent(
              email: widget.user.email,
              userId: widget.user.uid,
            );
          }),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: BottomNavigationBar(
          currentIndex: currentIdex,
          onTap: (newIndex) {
            setState(() {
              currentIdex = newIndex;
            });
          },
          backgroundColor: const Color.fromARGB(44, 8, 3, 3),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white,
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
      ),
    );
  }
}
