part of 'my_account_cubit.dart';

class MyAccountState {
  final bool isLoading;
  final String errorMessage;
  final List<OpinionModel> userOpinions;

  const MyAccountState({
    required this.isLoading,
    required this.errorMessage,
    required this.userOpinions,
  });
}
