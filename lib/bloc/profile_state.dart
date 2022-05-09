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
  @override
  List<Object> get props => [];
}
class loadingfollowing extends ProfileState {
  @override
  List<Object> get props => [];
}
class loadedfollowing extends ProfileState {
  @override
  List<Object> get props => [];
}
class loading_otherPosts extends ProfileState {
  @override
  List<Object> get props => [];
}
class loaded_otherPosts extends ProfileState {
  @override
  List<Object> get props => [];
}
class profileError extends ProfileState {
  final String error;
  profileError(this.error);
  @override
  List<Object?> get props => [error];
}