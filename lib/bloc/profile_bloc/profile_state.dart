part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}
class loadingfollowers extends ProfileState {


  @override
  List<Object> get props => [];
}
class loadedfollowers extends ProfileState {
  List<user>followers;

  loadedfollowers(this.followers);
  @override
  List<Object> get props => [];
}
class failedloadfollowers extends ProfileState {
  @override
  List<Object> get props => [];
}
class loadingfollowing extends ProfileState {
  @override
  List<Object> get props => [];
}
class loadedfollowing extends ProfileState {
  List<user>following;

  loadedfollowing(this.following);
  @override
  List<Object> get props => [];
}
class loading_otherPosts extends ProfileState {
  @override
  List<Object> get props => [];
}
class loaded_otherPosts extends ProfileState {
  List<post>other_posts;

  loaded_otherPosts(this.other_posts);

  @override
  List<Object> get props => [];
}
class loading_Posts extends ProfileState {
  @override
  List<Object> get props => [];
}
class loaded_Posts extends ProfileState {
  List<post>Posts;

  loaded_Posts(this.Posts);

  @override
  List<Object> get props => [];
}

class profileError extends ProfileState {
  final String error;
  profileError(this.error);
  @override
  List<Object?> get props => [error];
}