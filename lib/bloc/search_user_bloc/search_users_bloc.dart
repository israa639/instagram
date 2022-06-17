import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/user.dart';
import '../../data/repository/userProfileManagementRepository.dart';
import '../../data/repository/user_repository.dart';

part 'search_users_event.dart';
part 'search_users_state.dart';

class SearchUsersBloc extends Bloc<SearchUsersEvent, SearchUsersState> {
  final UserRepository userRepository;
  final UserProfileManagemetRepository userProfileRepo;

  SearchUsersBloc({required this.userRepository,required this.userProfileRepo}) : super(SearchStateEmpty()) {
    on<TextChanged>((event, emit)async {
      emit(SearchStateLoading ());
      try{
       final users= await this.userRepository.getUsersByUserName(event.user_name);
       users.map(( User) async => User.set_profile_img_downloaded_url(this.userProfileRepo.loadProfileImage(User.profile_img_url!)));

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
