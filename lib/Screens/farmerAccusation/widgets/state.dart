abstract class MyState {}

class MyInitialState extends MyState {}

class MyLoadingState extends MyState {}

class MySuccessState extends MyState {
}

class MyErrorState extends MyState {
  final String error;
  MyErrorState(this.error);
}
