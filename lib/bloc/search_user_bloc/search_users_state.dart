part of 'search_users_bloc.dart';

abstract class SearchUsersState extends Equatable {
  const SearchUsersState();
}


class SearchStateEmpty extends SearchUsersState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'SearchStateEmpty';
}

class SearchStateLoading extends SearchUsersState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'SearchStateLoading';
}

class SearchStateSuccess extends SearchUsersState {

  final List<user> search_result;
  final String query;

  SearchStateSuccess(this.search_result, this.query);
  @override
  List<Object> get props => [];


  @override
  String toString() => 'SearchStateSuccess { songs: ${ search_result.length} }';
}

class SearchStateError extends SearchUsersState {
  final String error;

  SearchStateError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SearchStateError { error: $error }';
}