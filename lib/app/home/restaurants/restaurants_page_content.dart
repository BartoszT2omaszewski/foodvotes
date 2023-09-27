import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/restaurant_details/restaurant_details_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cubit/restaurants_cubit.dart';

class RestaurantsPageContent extends StatelessWidget {
  const RestaurantsPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantsCubit()..start(),
      child: BlocBuilder<RestaurantsCubit, RestaurantsState>(
        builder: (context, state) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Witaj w naszej aplikacji',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  controller: context.read<RestaurantsCubit>().controller,
                  onChanged: ((value) => context.read<RestaurantsCubit>().updateData(value)),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: 'Wyszukiwanie',
                    hintStyle: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white.withAlpha(50),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Najlepiej oceniane restauracje',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              BlocBuilder<RestaurantsCubit, RestaurantsState>(
                builder: (context, state) {
                  if (state.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        'Coś poszło nie tak! : ${state.errorMessage} ',
                      ),
                    );
                  }

                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final documents = state.documents;

                  return Column(
                    children: [
                      for (final document in documents) ...[
                        InkWell(
                          highlightColor: Colors.transparent,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RestaurantDetailsPage(
                                name: document['name'],
                                location: document['location'],
                                description: document['description'],
                                rating: document['rating'],
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        document['name'],
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Text(document['location'], style: const TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                  Text(
                                    'Ocena: ${document['rating'].toString()}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
