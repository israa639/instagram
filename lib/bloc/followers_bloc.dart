import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'followers_event.dart';
part 'followers_state.dart';

class FollowersBloc extends Bloc<FollowersEvent, FollowersState> {
  FollowersBloc() : super(FollowersInitial()) {
    on<FollowersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
