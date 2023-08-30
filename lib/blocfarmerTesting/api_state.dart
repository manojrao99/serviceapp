
part of 'api_blco.dart';

@immutable
abstract class ApiState {}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {}
class Apicall extends ApiState {}
class UpdateDataEvent extends ApiState {
  final List<Device> newData;

  UpdateDataEvent(this.newData);

  @override
  List<Object?> get props => [newData];
}
class ListsData extends ApiState {
  final List<Device> items;

   ListsData(this.items);

  @override
  List<Device?> get props => items;
}
class ApiLoaded extends ApiState {
  final List<Device> posts;

  ApiLoaded({required this.posts});

  @override
  List<Device> get props => posts;
}


class ApiError extends ApiState {
  final String errorMessage;

  ApiError({required this.errorMessage});
}
