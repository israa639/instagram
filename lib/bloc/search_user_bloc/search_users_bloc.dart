import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/user.dart';
import '../../data/repository/user_repository.dart';

part 'search_users_event.dart';
part 'search_users_state.dart';

class SearchUsersBloc extends Bloc<SearchUsersEvent, SearchUsersState> {
  final UserRepository userRepository;
  SearchUsersBloc({required this.userRepository}) : super(SearchStateEmpty()) {
    on<TextChanged>((event, emit)async {
      emit(SearchStateLoading ());
      try{
       final users= await this.userRepository.getUsersByUserName(event.user_name);
       users.map((user) =>user.profile_img_downloaded_url= this.userRepository.loadImage(user.profile_img_url!));

            emit(SearchStateSuccess(users,event.user_name));


      }
catch(e)
      {
        emit(SearchStateError(e.toString()));
      }
    });
    @override
    void onTransition(Transition<SearchUsersEvent, SearchUsersState> transition) {
      print(transition);
      super.onTransition(transition);
    }
  }
}
