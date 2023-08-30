part of 'MyBloc.dart';


abstract class MyBlocState extends Equatable {
  const MyBlocState();

  @override
  List<Object?> get props => [];
}
class MyBlocInitial extends MyBlocState {}
class MyBlocLoadingState extends MyBlocState {}

class MyBlocLoadedState extends MyBlocState {
  final Device data;

  MyBlocLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class MyBlocErrorState extends MyBlocState {}
