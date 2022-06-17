import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/post.dart';
import '../../data/models/user.dart';
import '../../data/repository/comment_repository.dart';
import '../../data/repository/userProfileManagementRepository.dart';
import 'package:quiver/collection.dart';
part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  commentRepository commentRepo;
  final UserProfileManagemetRepository userProfileRepo;


  CommentBloc( {required this.commentRepo,required this.userProfileRepo}) : super(LoadingGetComments ()) {
    on<viewcommentEvent>((event, emit) async {
      emit(LoadingGetComments());
      try {

      await userProfileRepo.getPostComments(event.Post.comments).then(( Multimap<user, String>UserComment ) { emit(CommentsLoaded(UserComment));});

      }
      catch (e) {
        emit(failedloadComment (e.toString()));
      }
    });
    on<addcommentEvent>((event, emit) async {

      emit(loadingAddComment());
      try {

        await commentRepo.AddComment(event.CommentText, event.UserId!,event.Post.postId!).then((String commentId){event.Post.comments.add(commentId);});

        await userProfileRepo.getPostComments(event.Post.comments).then(( Multimap<user, String>UserComment ) { emit(commentAddedSuccessfully(UserComment));});

      }catch(e) {
        emit(failedAddComment(e.toString()));
      }
    });
  }
  @override
  void onTransition(Transition<CommentEvent, CommentState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}

