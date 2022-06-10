import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/post.dart';
import '../../data/repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepo;
  String userName;
  int postNo;

  PostBloc({required this.postRepo,required this.userName,required this.postNo}) : super(InitialPostState()) {
    on<addPostEvent>((event, emit) {
     emit(Loading());
     try {
       postRepo.AddPost(
           event.newPost, event.File_image, this.userName, this.postNo);
       emit(PostAddedSuccessfully(event.newPost,event.File_image));
     }
     catch(e){

     }
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
