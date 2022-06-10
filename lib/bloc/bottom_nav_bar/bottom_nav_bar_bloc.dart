import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/post.dart';
import '../../data/models/user.dart';
import '../../data/repository/auth_repository.dart';

part 'bottom_nav_bar_event.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  int current_index=0;
  final AuthRepository authRepository;




    BottomNavBarBloc({required this.authRepository}) : super(PageLoading()) {

    on<AppStarted>((event, emit) {
      emit(PageLoading());
      try {
        emit(HomePageLoaded());
      }
      catch(e){
        emit(PageLoadedError(e.toString()));
      }
    });
    on<PageTapped>((event, emit) {
      this.current_index=event.index;
      emit(PageLoading());
      if(this.current_index==0)
      {try {
        emit(HomePageLoaded());
      }
      catch(e){
        emit(PageLoadedError(e.toString()));
      }}
      if(this.current_index==1)
      {try {
        emit(SearchPageLoaded());
      }
      catch(e){
        emit(PageLoadedError(e.toString()));
      }}
      if(this.current_index==2)
      {try {
        emit(AddPostPageLoaded());
      }
      catch(e){
        emit(PageLoadedError(e.toString()));
      }}
      if(this.current_index==3)
      {try {
        emit(ProfilePageLoaded(current_user: this.authRepository.current_user));
      }
      catch(e){
        emit(PageLoadedError(e.toString()));
      }}
      if(this.current_index==4)
      {try {
        emit(ProfilePageLoaded(current_user: this.authRepository.current_user));
      }
      catch(e){
        emit(PageLoadedError(e.toString()));
      }}
    });
  }
  @override
  void onTransition(Transition<BottomNavBarEvent, BottomNavBarState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
