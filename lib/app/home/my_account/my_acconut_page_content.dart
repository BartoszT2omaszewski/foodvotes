import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najlepsza_pizza_w_miescie/app/cubit/root_cubit.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/my_account/widgets/opinion_widget.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/my_account/widgets/text_field_widget.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/my_account/widgets/visitors_widget.dart';

class MyAccountPageContent extends StatelessWidget {
  MyAccountPageContent({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String? email;
  final nameControler = TextEditingController();
  final emailControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailControler.text = email ?? '';
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('images/kuchnia.jpg'),
            ),
            TextFieldWidget(title: 'Imie', controller: nameControler),
            TextFieldWidget(title: 'Adres email', controller: emailControler),
            const SizedBox(
              height: 20,
            ),
            const VisitorsWidget(),
            const SizedBox(
              height: 20,
            ),
            const OpinionWidget(),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              child: const Text('Wyloguj się',
                  style: TextStyle(fontSize: 25, color: Colors.white)),
              onTap: () {
                context.read<RootCubit>().signOut();
              },
            ),
          ]),
    );
  }
}
