
part of 'acausationblock.dart';
// @immutable
abstract class PostsState {}
abstract class PostsActionState extends PostsState {}
class PostsInitial extends PostsState {}
class PostsFetchingLoadingState extends PostsState {}
class PostsFetchingErrorState extends PostsState {
final String eroor;
PostsFetchingErrorState({required this.eroor});
}
class PostFetchingSuccessfulState extends PostsState {
  final List<District> posts;
  PostFetchingSuccessfulState({
    required this.posts,
  });
}
class PostsAdditionSuccessState extends PostsActionState{}
class PostsAdditionErrorState extends PostsActionState{}

