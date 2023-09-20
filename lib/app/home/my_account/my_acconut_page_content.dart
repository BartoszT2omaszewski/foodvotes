import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najlepsza_pizza_w_miescie/app/cubit/root_cubit.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/my_account/widgets/text_field_widget.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('images/kuchnia.jpg'),
          ),
          Text('Jesteś zalogowany jako $email'),
          TextFieldWidget(title: 'Imie', controller: nameControler),
          TextFieldWidget(title: 'Adres email', controller: emailControler),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<RootCubit>().signOut();
            },
            child: const Text('Wyloguj się'),
          ),
        ],
      ),
    );
  }
}
