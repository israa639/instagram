part of 'search_users_bloc.dart';

abstract class SearchUsersEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class TextChanged extends SearchUsersEvent {
  final String user_name;

  TextChanged({required this.user_name}) ;

  @override
  String toString() => "SongSearchTextChanged { query: $user_name }";
}