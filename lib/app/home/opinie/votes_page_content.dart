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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                    child: Text('Sortuj według (Od najniższej)'),
                  ),
                  DropdownMenuItem(
                    value: 'rating_desc',
                    child: Text('Sortuj według (Od najwyższej)'),
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
                  child: Text(
                    'Coś poszło nie tak! : ${state.errorMessage} ',
                    textAlign: TextAlign.center,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                document['name'],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                document['pizza'],
                              ),
                              Text(
                                document['location'],
                              ),
                              Text(
                                document['description'],
                              ),
                            ],
                          ),
                          Text(
                            document['rating'].toString(),
                          ),
                        ],
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
