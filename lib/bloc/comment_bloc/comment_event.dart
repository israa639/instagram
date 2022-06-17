part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  @override
  List<Object> get props => [];

}
class viewcommentEvent extends CommentEvent {


  post Post;

  viewcommentEvent(this.Post);
}

class addcommentEvent extends CommentEvent {
  String CommentText;
  String? UserId;
  //String postId;
  post Post;

  addcommentEvent(this.CommentText, this.UserId,this.Post);
}
