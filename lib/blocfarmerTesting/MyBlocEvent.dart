part of 'MyBloc.dart';


abstract class MyBlocEvent extends Equatable {
  const MyBlocEvent();

  @override
  List<Object?> get props => [];
}

class FetchDataButtonPressedEvent extends MyBlocEvent {
  final bool shouldCallApi1;
  final String farmerID; // farmerID as a parameter

  FetchDataButtonPressedEvent({required this.shouldCallApi1, required this.farmerID});

  @override
  List<Object?> get props => [shouldCallApi1, farmerID];
}