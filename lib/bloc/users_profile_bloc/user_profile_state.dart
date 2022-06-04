part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();
}




class ProfileInitial extends UserProfileState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'SearchStateEmpty';
}
class loadingfollowers extends UserProfileState {


  @override
  List<Object> get props => [];
  @override
  String toString() => 'loadingfollowers';
}
class loadedfollowers extends UserProfileState{
  List<user>followers;

  loadedfollowers(this.followers);
  @override
  List<Object> get props => [];
  @override
  String toString() => 'loadedfollowers';
}
class failedloadfollowers extends UserProfileState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'failedloadfollowers';
}
class loadingfollowing extends UserProfileState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'loadingfollowing';
}
class loadedfollowing extends UserProfileState{
  List<user>following;

  loadedfollowing(this.following);
  @override
  List<Object> get props => [];

  @override
  String toString() => 'loadedfollowing';
}
class loading_otherPosts extends UserProfileState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'loading_otherPosts';
}
class loaded_otherPosts extends UserProfileState {
  List<post>other_posts;

  loaded_otherPosts(this.other_posts);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'loaded_otherPosts';
}
class loading_Posts extends UserProfileState{
  @override
  List<Object> get props => [];

  @override
  String toString() => 'loading_Posts';
}
class loaded_Posts extends UserProfileState {
  List<post>Posts;

  loaded_Posts(this.Posts);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'loaded_Posts';
}

class profileError extends UserProfileState {
  final String error;
  profileError(this.error);
  @override
  List<Object?> get props => [error];

  @override
  String toString() => 'profileError';
}