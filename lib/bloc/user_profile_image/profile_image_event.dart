part of 'profile_image_bloc.dart';

abstract class ProfileImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class RequestUpdateProfileImageEvent extends ProfileImageEvent {

  final File File_image;


  RequestUpdateProfileImageEvent (this.File_image);
}
class RequestRemoveProfileImageEvent extends ProfileImageEvent {
  @override
  List<Object> get props => [];

}