part of 'acausationblock.dart';

// @immutable
abstract class PostsEvent {}


class PostsInitialFetchEvent extends PostsEvent{}
class GetTaluka extends PostsEvent{}

class GetVillage extends PostsEvent{}

class PostFarmerData extends PostsEvent{
  final FarmerAcusationDart body;
  final bool locally;
  PostFarmerData({required this.body,required this.locally});
}

