import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/post.dart';
import '../../data/models/user.dart';
import '../../data/repository/post_repository.dart';
import '../../data/repository/user_actions_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepo;
  UserActivitiesRepository userActivityRepo;
  user currentUser;
  int postNo;

  PostBloc({required this.postRepo,required this.currentUser,required this.postNo,required this.userActivityRepo}) : super( NoImageSelected()) {
    //emit(ImageSelected());
    on<selectImageEvent>((event, emit){
      emit(ImageSelected());
    });
    on<addPostEvent>((event, emit) {

     emit(Loading());
     try {
      postRepo.AddPost(
           event.caption, event.File_image, this.currentUser.username, this.postNo).then(
          (String newPostId){
            this.userActivityRepo.setUser(currentUser);
            this.userActivityRepo.addPost(newPostId);
          }
      );

       emit(PostAddedSuccessfully(event.caption,event.File_image));

     }
     catch(e){
emit(PostAddedFailed(e.toString()));
     }
    });
    on<postAddedFinished>((event, emit) {
      emit(NoImageSelected());
    });
    on<deletePostEvent>((event, emit) {

    });
  }
  @override
  void onTransition(Transition<PostEvent, PostState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
