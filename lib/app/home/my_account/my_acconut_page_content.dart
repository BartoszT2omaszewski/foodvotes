import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najlepsza_pizza_w_miescie/app/cubit/root_cubit.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/my_account/cubit/my_account_cubit.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/my_account/widgets/opinion_widget.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/my_account/widgets/text_field_widget.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/my_account/widgets/text_widget.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/my_account/widgets/visitors_widget.dart';
import 'package:najlepsza_pizza_w_miescie/app/model/opinion_model.dart';

class MyAccountPageContent extends StatefulWidget {
  const MyAccountPageContent({
    Key? key,
    required this.email,
    required this.userId,
  }) : super(key: key);

  final String? email;
  final String userId;

  @override
  State<MyAccountPageContent> createState() => _MyAccountPageContentState();
}

class _MyAccountPageContentState extends State<MyAccountPageContent> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  bool isSortDescending = true;
  List<OpinionModel> userOpinions = [];

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAccountCubit()..start(widget.userId),
      child: BlocBuilder<MyAccountCubit, MyAccountState>(
        builder: (context, state) {
          userOpinions = [...state.userOpinions];

          if (isSortDescending) {
            userOpinions.sort((a, b) => b.rating.compareTo(a.rating));
          } else {
            userOpinions.sort((a, b) => a.rating.compareTo(b.rating));
          }

          return Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/kuchnia.jpg'),
                  ),
                  TextFieldWidget(title: 'Imie', controller: nameController),
                  TextFieldWidget(title: 'Adres email', controller: emailController),
                  const SizedBox(
                    height: 20,
                  ),
                  const VisitorsWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: TextWidget(title: 'MOJE OPINIE:', fontSize: 25),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextWidget(title: 'Sortuj po ocenie', fontSize: 18),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isSortDescending = false;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_upward,
                            color: Colors.white60,
                            size: 32,
                          )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isSortDescending = true;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_downward,
                            color: Colors.white60,
                            size: 32,
                          )),
                    ],
                  ),
                  OpinionWidget(opinions: userOpinions),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: const Text('Wyloguj się', style: TextStyle(fontSize: 25, color: Colors.white)),
                    onTap: () {
                      context.read<RootCubit>().signOut();
                    },
                  ),
                ]),
          );
        },
      ),
    );
  }
}
