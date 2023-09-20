import 'package:flutter/material.dart';

class VisitorsWidget extends StatelessWidget {
  const VisitorsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(8),
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
      child: const Center(
        child: Column(
          children: [
            Text(
              'Odwiedzających',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white54,
              ),
            ),
            Text(
              '34',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
