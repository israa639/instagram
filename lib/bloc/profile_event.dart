part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}
 class showFollowers extends ProfileEvent{

  List<dynamic> followers;

  showFollowers(this.followers);


}
class showFollowing extends ProfileEvent{

  List<dynamic> following;

  showFollowing(this.following);

}
class updateProfile extends ProfileEvent{

}
class updateProfilePicture extends ProfileEvent{

}
class addPost extends ProfileEvent{

}
class showOtherPosts extends ProfileEvent{
  List<dynamic> other_posts;

  showOtherPosts(this.other_posts);
}
class showMyPosts extends ProfileEvent{
  List<dynamic> my_posts;

  showMyPosts(this.my_posts);
}