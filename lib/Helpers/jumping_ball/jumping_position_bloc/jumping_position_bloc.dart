import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'jumping_position_event.dart';
part 'jumping_position_state.dart';

class JumpingPositionBloc
    extends Bloc<JumpingPositionEvent, JumpingPositionState> {
  JumpingPositionBloc() : super(const JumpingPositionState()) {
    on<JumpingPositionMoved>(_onMoved);
    on<JumpingPositionSetTarget>(_onSetTarget);
  }

  _onMoved(JumpingPositionMoved event, Emitter<JumpingPositionState> emit) {
    print(event.position);
    emit(state.copyWith(position: event.position, display: true));
  }

  _onSetTarget(
      JumpingPositionSetTarget event, Emitter<JumpingPositionState> emit) {
    print(event.position);
    emit(state.copyWith(target: event.position));
  }
}
