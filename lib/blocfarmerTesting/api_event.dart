part of 'api_blco.dart';

@immutable
abstract class ApiEvent {}

class FetchData extends ApiEvent {}
class UpdateArrayPositionEvent extends ApiEvent {
  final int index;
  final Device newValue;

  UpdateArrayPositionEvent(this.index, this.newValue);

  @override
  List<Object?> get props => [index, newValue];
}
class AddItemEvent extends ApiEvent {
  final Device newItem;

  AddItemEvent(this.newItem);

  @override
  List<Device> get props => [newItem];
}

class RemoveItemEvent extends ApiEvent {
  final Device item;

  RemoveItemEvent(this.item);

  @override
  List<Object?> get props => [item];
}
