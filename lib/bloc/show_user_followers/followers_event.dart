part of 'followers_bloc.dart';

abstract class FollowersEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class loadfollowersEvent extends FollowersEvent{
      final List<user> followers;

      loadfollowersEvent(this.followers);
}