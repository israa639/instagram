part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class addPostEvent extends PostEvent {
  String caption;
  File? File_image;


  addPostEvent(this.caption,this.File_image);
}
class selectImageEvent extends PostEvent {
  @override
  List<Object> get props => [];
}
class postAddedFinished extends PostEvent {
  @override
  List<Object> get props => [];
}

class deletePostEvent extends PostEvent {
     String post_id;

     deletePostEvent(this.post_id);
}
