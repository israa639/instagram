part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}
class FollowUserSuccessfully extends ProfileState {


  @override
  List<Object> get props => [];
}

class loadingFollowers extends ProfileState {


  @override
  List<Object> get props => [];
}
class loadedFollowersSuccessfully extends ProfileState {
  List<user>followers;

  loadedFollowersSuccessfully(this.followers);
  @override
  List<Object> get props => [];
}
class failedLoadFollowers extends ProfileState {
  @override
  List<Object> get props => [];
}
class loadingFollowing extends ProfileState {
  @override
  List<Object> get props => [];
}
class loadedFollowingSuccessfully extends ProfileState {
  List<user>following;

  loadedFollowingSuccessfully(this.following);
  @override
  List<Object> get props => [];
}
class loading_otherPosts extends ProfileState {
  @override
  List<Object> get props => [];
}
class loaded_otherPostsSuccessfully extends ProfileState {
  List<post>other_posts;

  loaded_otherPostsSuccessfully(this.other_posts);

  @override
  List<Object> get props => [];
}
class loading_Posts extends ProfileState {
  @override
  List<Object> get props => [];
}
class loaded_PostsSuccessfully extends ProfileState {
  List<post>Posts;

  loaded_PostsSuccessfully(this.Posts);

  @override
  List<Object> get props => [];
}


class profileError extends ProfileState {
  final String error;
  profileError(this.error);
  @override
  List<Object?> get props => [error];
}