import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/restaurants_cubit.dart';

class RestaurantsPageContent extends StatelessWidget {
  const RestaurantsPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantsCubit()..start(),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Witaj w naszej aplikacji',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 18,
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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(
                              15.0), 
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
                                Text(document['location'],
                                    style:
                                        const TextStyle(color: Colors.white)),
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
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
