import 'package:flutter/material.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/my_account/widgets/text_widget.dart';
import 'package:najlepsza_pizza_w_miescie/app/model/opinion_model.dart';

class OpinionWidget extends StatelessWidget {
  const OpinionWidget({
    Key? key,
    required this.opinions,
  }) : super(key: key);

  final List<OpinionModel> opinions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white54, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: opinions.length,
        itemBuilder: (context, index) {
          final opinion = opinions[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white54, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(title: 'Nazwa restauracji:  ${opinion.restaurantName}', fontSize: 20),
                      TextWidget(title: 'Danie: ${opinion.pizzaName}', fontSize: 20),
                      TextWidget(title: 'Ocena: ${opinion.rating}', fontSize: 20),
                    ],
                  ),
                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextWidget(title: 'komentarze: 0 ', fontSize: 18),
                      TextWidget(title: 'głosy: 0 ', fontSize: 18),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
