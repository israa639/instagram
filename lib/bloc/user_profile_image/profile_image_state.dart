part of 'profile_image_bloc.dart';

abstract class ProfileImageState extends Equatable {
  const ProfileImageState();
}

class ProfileImageInitial extends ProfileImageState {
Future<String>? profile_img_url;

ProfileImageInitial({this.profile_img_url});

  @override
  List<Object> get props => [];
}
class NoProfileImage extends ProfileImageState {
  @override
  List<Object> get props => [];
}
class ProfileImageLoaded extends ProfileImageState {
  @override
  List<Object> get props => [];
}

class loadingUpdatedProfileImage extends ProfileImageState {

  @override
  List<Object?> get props => [];
}

class ProfileImageUpdatedSuccessfully extends ProfileImageState {
  final File profile_img;

  ProfileImageUpdatedSuccessfully(this.profile_img);

  @override
  List<Object> get props => [];
}

class failedUpdateProfileImage extends ProfileImageState {

  final String error;

  failedUpdateProfileImage(this.error);

  @override
  List<Object?> get props => [error];
}
class ProfileImageRemovedSuccessfully extends ProfileImageState {

  @override
  List<Object> get props => [];
}

class failedRemoveProfileImage extends ProfileImageState {

  final String error;

  failedRemoveProfileImage(this.error);

  @override
  List<Object?> get props => [error];
}