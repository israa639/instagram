part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}
class Loading extends PostState {

  @override
  List<Object> get props => [];
}
class NoImageSelected extends PostState {

  @override
  List<Object> get props => [];
}
class ImageSelected extends PostState {

  @override
  List<Object> get props => [];
}
class PostAddedSuccessfully extends PostState {
  String postCaption;
   File? profile_img;


  PostAddedSuccessfully(this.postCaption,this.profile_img);

  @override
  List<Object> get props => [];
}
class PostAddedFailed extends PostState {
  String error;

  PostAddedFailed(this.error);

  @override
  List<Object> get props => [];
}
class PostRemovedSuccessfully extends PostState {

  @override
  List<Object> get props => [];
}