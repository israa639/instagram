import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/user.dart';
import '../../data/repository/auth_repository.dart';

part 'profile_image_event.dart';
part 'profile_image_state.dart';

class ProfileImageBloc extends Bloc<ProfileImageEvent, ProfileImageState> {
  final AuthRepository authRepository;
  late final user current_user;

  ProfileImageBloc({required this.authRepository,required this.current_user}) : super(ProfileImageInitial()) {
    if(authRepository.current_user.profile_img_url!=null)
    {
      current_user.profile_img_downloaded_url=authRepository.loadImage(authRepository.current_user.profile_img_url!);
      emit( ProfileImageInitial ( profile_img_url:authRepository.current_user.profile_img_downloaded_url));
    }
   else{
      emit( ProfileImageInitial());
      }

    on<RequestUpdateProfileImageEvent>((event, emit) {
      emit(loadingUpdatedProfileImage());
         try{
        this.authRepository.updateProfileImg(event.File_image);
        this.authRepository.current_user.set_profile_img_url(  this.authRepository.current_user.username);
        this.authRepository.delete_user(this.authRepository.current_user.userId!);
        this.authRepository.createUser(this.authRepository.current_user);
        emit(ProfileImageUpdatedSuccessfully(event.File_image));
}
catch(e){
  emit(failedUpdateProfileImage(e.toString()));
}



    });
    on<RequestRemoveProfileImageEvent>((event, emit) {
      emit(loadingUpdatedProfileImage());





    });
  }
  @override
  void onTransition(Transition<ProfileImageEvent, ProfileImageState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
