part of 'profile_bloc.dart';
abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}


 class RequestshowFollowers extends ProfileEvent{
  user SearchUser;

  RequestshowFollowers(this.SearchUser);

  @override
   List<Object> get props => [];
}
class RequestshowFollowing extends ProfileEvent{
  user SearchUser;

  RequestshowFollowing(this.SearchUser);

  @override
  List<Object> get props => [];
}
class RequestLoadPosts extends ProfileEvent{
  user SearchUser;

  RequestLoadPosts(this.SearchUser);

}

class RequestFollow extends ProfileEvent{
  user SearchUser;

  RequestFollow(this.SearchUser);

  @override
  List<Object> get props => [];
}
class RequestUnfollow extends ProfileEvent{
  user SearchUser;

  RequestUnfollow(this.SearchUser);

  @override
  List<Object> get props => [];
}