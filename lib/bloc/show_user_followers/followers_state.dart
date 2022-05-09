part of 'followers_bloc.dart';

abstract class FollowersState extends Equatable {
  const FollowersState();
}

class LoadingFollowers extends FollowersState {
  @override
  List<Object?> get props => [];
}
class LoadedFollowers extends FollowersState {
  final List<user> following;

 const LoadedFollowers({required this.following});
  @override
  List<Object?> get props => [];
}