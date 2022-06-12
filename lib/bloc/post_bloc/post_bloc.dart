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

  PostBloc({required this.postRepo,required this.userName,required this.postNo}) : super( ImageSelected()) {
    //emit(ImageSelected());
    on<addPostEvent>((event, emit) {

     emit(Loading());
     try {
       postRepo.AddPost(
           event.caption, event.File_image, this.userName, this.postNo);
       emit(PostAddedSuccessfully(event.caption,event.File_image));
     }
     catch(e){
emit(PostAddedFailed(e.toString()));
     }
    });
    on<postAddedFinished>((event, emit) {

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
