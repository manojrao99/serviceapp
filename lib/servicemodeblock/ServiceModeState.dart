
part of 'ServiceMode.dart';

@immutable
abstract class ServiceModeState {}

class ApiInitial extends ServiceModeState {}

class ApiLoading extends ServiceModeState {}
class Apicall extends ServiceModeState {}
class UpdateDataEvent extends ServiceModeState {
  final List<Device> newData;

  UpdateDataEvent(this.newData);

  @override
  List<Object?> get props => [newData];
}
class ListsData extends ServiceModeState {
  final List<Device> items;

  ListsData(this.items);

  @override
  List<Device?> get props => items;
}
class ApiLoaded extends ServiceModeState {
  final List<Device> posts;

  ApiLoaded({required this.posts});

  @override
  List<Device> get props => posts;
}


class ApiError extends ServiceModeState {
  final String errorMessage;

  ApiError({required this.errorMessage});
}
