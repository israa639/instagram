part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();
}
class LoadingGetComments extends CommentState {
  @override
  List<Object> get props => [];
}
class CommentsLoaded extends CommentState {
 // List<user>commenters;
  //List<String>comments;
  Multimap<user, String>UserComment ;
  CommentsLoaded(this.UserComment);
  @override
  List<Object> get props => [];


}
class loadingAddComment extends CommentState {
  @override
  List<Object> get props => [];
}
class commentAddedSuccessfully extends CommentState {
  Multimap<user, String>UserComment ;
  commentAddedSuccessfully(this.UserComment);
  @override
  List<Object> get props => [];
}
class failedAddComment extends CommentState {
  String error;

  failedAddComment(this.error);

  @override
  List<Object> get props => [];
}
class failedloadComment extends CommentState {
  String error;

  failedloadComment (this.error);

  @override
  List<Object> get props => [];
}