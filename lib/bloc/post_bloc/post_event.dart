part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class addPostEvent extends PostEvent {
  post newPost;
  final File File_image;


  addPostEvent(this.newPost,this.File_image);
}
class deletePostEvent extends PostEvent {
     String post_id;

     deletePostEvent(this.post_id);
}
