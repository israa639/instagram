part of 'bottom_nav_bar_bloc.dart';

abstract class BottomNavBarState extends Equatable {
  const BottomNavBarState();
}

class CurrentIndexChanged extends BottomNavBarState {
  final int currentIndex;

  CurrentIndexChanged({required this.currentIndex}) ;

  @override
  List<Object> get props => [];
}

class PageLoading extends BottomNavBarState {
  @override
  List<Object> get props => [];
}

class HomePageLoaded extends BottomNavBarState {

  @override
  List<Object> get props => [];
}


class ProfilePageLoaded extends BottomNavBarState {

  final user current_user;

  ProfilePageLoaded({required this.current_user});

  @override
  List<Object> get props => [];
}
class SearchPageLoaded extends BottomNavBarState {

  @override
  List<Object> get props => [];
}
class AddPostPageLoaded extends BottomNavBarState {

  @override
  List<Object> get props => [];
}
class PageLoadedError extends BottomNavBarState{
  final String error;
  PageLoadedError(this.error);
  @override
  List<Object> get props => [];
}