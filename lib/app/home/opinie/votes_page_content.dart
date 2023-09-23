import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/opinie/cubit/votes_cubit.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/opinie/cubit/votes_state.dart';

class VotesPageContent extends StatefulWidget {
  const VotesPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<VotesPageContent> createState() => _VotesPageContentState();
}

class _VotesPageContentState extends State<VotesPageContent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<VotesCubit>(
      create: (context) => VotesCubit()..start(),
      child: Container(
        padding: const EdgeInsets.all(20.0), // Padding dla całej zawartości
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Wszystkie opinie w jednym miejscu',
                style: TextStyle(fontSize: 24, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Builder(
              builder: (newContext) {
                return DropdownButton<String>(
                  value: 'rating',
                  items: const [
                    DropdownMenuItem(
                      value: 'rating',
                      child: Text(
                        'Sortuj według (Od najniższej)',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'rating_desc',
                      child: Text(
                        'Sortuj według (Od najwyższej)',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      newContext.read<VotesCubit>().changeSorting(newValue);
                    }
                  },
                );
              },
            ),
            const SizedBox(
              height: 18,
            ),
            BlocBuilder<VotesCubit, VotesState>(
              builder: (context, state) {
                if (state.errorMessage.isNotEmpty) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Text(
                        'Coś poszło nie tak! : ${state.errorMessage} ',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
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
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Nazwa restauracji: ${document['name']}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                'Miasto: ${document['location']}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Opis: ${document['description']}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Danie: ${document['pizza']}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 15,
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
      ),
    );
  }
}
