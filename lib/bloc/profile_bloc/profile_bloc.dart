import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/post.dart';
import '../../data/models/user.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/userProfileManagementRepository.dart';
import '../../data/repository/user_actions_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final user current_user;
  final UserProfileManagemetRepository userProfileRepo;
  UserActivitiesRepository userActivityRepo;


  ProfileBloc({required this.current_user,required this.userProfileRepo,required this.userActivityRepo}) : super(loading_Posts()) {

    on<RequestLoadPosts>((event, emit) {
     emit(loading_Posts());
     try{
       userProfileRepo.setUserProfile(event.SearchUser);
       Future<String> x=userProfileRepo.loadProfileImage(event.SearchUser.profile_img_url!);
event.SearchUser.set_profile_img_downloaded_url( x );

       emit(loaded_PostsSuccessfully(event.SearchUser.posts!));
     }
      catch(e)
      {
        emit(profileError(e.toString()));
      }


    });
    on<RequestFollow>((event, emit) {

      try{
       userActivityRepo.Follow(current_user.userId!);

        emit(FollowUserSuccessfully());
      }
      catch(e)
      {
        emit(profileError(e.toString()));
      }


    });
  }
  @override
  void onTransition(Transition<ProfileEvent, ProfileState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
