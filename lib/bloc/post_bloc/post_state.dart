part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}
class Loading extends PostState {

  @override
  List<Object> get props => [];
}
class InitialPostState extends PostState {

  @override
  List<Object> get props => [];
}
class PostAddedSuccessfully extends PostState {
  post newpost;
  final File profile_img;


  PostAddedSuccessfully(this.newpost,this.profile_img);

  @override
  List<Object> get props => [];
}
class PostAddedFailed extends PostState {
  @override
  List<Object> get props => [];
}
class PostRemovedSuccessfully extends PostState {

  @override
  List<Object> get props => [];
}