part of 'ServiceMode.dart';

@immutable
abstract class ServiceModeEvent {}

class FetchData extends ServiceModeEvent {}
class UpdateArrayPositionEvent extends ServiceModeEvent {
  final int index;
  final Device newValue;

  UpdateArrayPositionEvent(this.index, this.newValue);

  @override
  List<Object?> get props => [index, newValue];
}
class AddItemEvent extends ServiceModeEvent {
  final Device newItem;

  AddItemEvent(this.newItem);

  @override
  List<Device> get props => [newItem];
}

class RemoveItemEvent extends ServiceModeEvent {
  final Device item;

  RemoveItemEvent(this.item);

  @override
  List<Object?> get props => [item];
}
