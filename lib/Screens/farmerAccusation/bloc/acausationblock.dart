import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '/Screens/farmerAccusation/farmeracusation_repositry.dart';
import '/Screens/farmerAccusation/model_classes/districs.dart';
import '/Screens/farmerAccusation/model_classes/farmer_model_saving.dart';

import '../../../utils/ErrorMessages.dart';

part 'acausation_block_event.dart';
part 'acausation_block_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepo repository = PostsRepo();

  PostsBloc() : super(PostsInitial());

  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    if (event is PostsInitialFetchEvent) {
      yield PostsFetchingLoadingState();
      try {
        final List<District> posts = await PostsRepo.fetchData();
        if (posts != []) {
          yield PostFetchingSuccessfulState(posts: posts);
        } else {
          yield (PostsFetchingErrorState(
              eroor: ErrorMessages.Distics_Featch_Eror));
        }
      } catch (e) {
        yield PostsFetchingErrorState(eroor: e.toString());
      }
    } else if (event is GetVillage) {
      bool success = await PostsRepo.fetchVillage();
      if (success) {
        // yield PostAddedState();
      } else {
        // yield PostsAdditionErrorState();
      }
    } else if (event is GetTaluka) {
      bool success = await PostsRepo.fetchTaluka();
      if (success) {
        // yield PostAddedState();
      } else {
        // yield PostsAdditionErrorState();
      }
    } else if (event is PostFarmerData) {
      bool success = await PostsRepo.PostFarmerData(event.body, event.locally);
      print("state ${success}");
      if (success) {
        yield (PostsAdditionSuccessState());
        // return true;
      } else {
        // return false;
      }
    }
  }
}


// class PostsBloc extends Bloc<PostsEvent, PostsState> {
//   PostsBloc() : super(PostsInitial()) {
//     on<PostsInitialFetchEvent>(postsInitialFetchEvent);
//     on<GetTaluka>(getTaluka);
//     on<GetVillage>(getVillage);
//     on<PostFarmerData>(postFarmerData);
//   }
//
//   FutureOr<void> postsInitialFetchEvent(
//       PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
//     emit(PostsFetchingLoadingState());
//     List<District> posts = await PostsRepo.fetchData();
// if(posts==[]){
// emit(PostsFetchingErrorState(eroor: ErrorMessages.Distics_Featch_Eror));
// }
// else {
//   emit(PostFetchingSuccessfulState(posts: posts));
// }
//   }
//
//   FutureOr<void> farmerDataPost(
//       PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
//     emit(PostsFetchingLoadingState());
//     List<District> posts = await PostsRepo.fetchData();
//     if(posts==[]){
//       emit(PostsFetchingErrorState(eroor: ErrorMessages.Distics_Featch_Eror));
//     }
//     else {
//       emit(PostFetchingSuccessfulState(posts: posts));
//     }
//   }
//
//
//
//   FutureOr<bool> postFarmerData(PostFarmerData event, Emitter<PostsState> emit) async
//   {
//
//  emit(PostsFetchingLoadingState());
//     bool success = await PostsRepo.PostFarmerData(event.body,event.locally);
//         if(success){
//           emit(PostsAdditionSuccessState());
//           return true;
//         }
//         else {
//           return false;
//         }
//
//
//   }
//   FutureOr<void> getTaluka(GetTaluka event, Emitter<PostsState> emit) async {
//     // emit(PostsFetchingLoadingState());
//     bool success = await PostsRepo.fetchTaluka();
//
//     if (success) {
//       // emit(PostsFetchingLoadingState());
//       // emit();
//     } else {
//       // emit(PostsAdditionErrorState());
//     }
//   }
//   FutureOr<void> getVillage(
//       GetVillage event, Emitter<PostsState> emit) async {
//     bool success = await PostsRepo.fetchVillage();
//
//     if (success) {
//       // emit(PostsAdditionSuccessState());
//     } else {
//       // emit(PostsAdditionErrorState());
//     }
//   }
// }

