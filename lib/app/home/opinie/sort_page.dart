import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/opinie/cubit/votes_cubit.dart';



class SortWidget extends StatelessWidget {
  const SortWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
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
    );
  }
}
