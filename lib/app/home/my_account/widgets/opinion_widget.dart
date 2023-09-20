import 'package:flutter/material.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/my_account/widgets/text_widget.dart';

class OpinionWidget extends StatelessWidget {
  const OpinionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: TextWidget(title: 'MOJE OPINIE:', fontSize: 25),
            ),
            Padding(
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(title: 'Nazwa restauracji:', fontSize: 20),
                        TextWidget(title: 'Danie:', fontSize: 20),
                        TextWidget(title: 'Ocena:', fontSize: 20),
                      ],
                    ),
                    Row(
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
            ),
          ],
        ),
        const TextWidget(title: 'głosy: 0 ', fontSize: 18),
      ],
    );
  }
}
