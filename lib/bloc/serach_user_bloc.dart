import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'serach_user_event.dart';
part 'serach_user_state.dart';

class SerachUserBloc extends Bloc<SerachUserEvent, SerachUserState> {
  SerachUserBloc() : super(SerachUserInitial()) {
    on<SerachUserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
