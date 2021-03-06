import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/post.dart';
import '../../data/models/user.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/userProfileManagementRepository.dart';
import '../../data/repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final UserRepository user_repository;
 final UserProfileManagemetRepository userProfileRepo;
  late final user current_user;
  AuthBloc({required this.authRepository,required this.user_repository,required this.userProfileRepo}) : super(UnAuthenticated()) {

    on<SignInRequested>((event, emit) async {

      emit(Loading());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);

       await  userProfileRepo.setUserProfile(this.authRepository.current_user);
        current_user=this.authRepository.current_user;

        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<SignUpRequested>((event, emit) async {

      emit(Loading());
      try {

        await authRepository.signUp(
            email: event.email, password: event.password,username: event.username,name:event.name);
        await  userProfileRepo.setUserProfile(this.authRepository.current_user);
        current_user=this.authRepository.current_user;

        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
     on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });

  }
  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}