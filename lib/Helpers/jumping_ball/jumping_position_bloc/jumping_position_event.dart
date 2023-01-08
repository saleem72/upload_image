// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'jumping_position_bloc.dart';

abstract class JumpingPositionEvent extends Equatable {
  const JumpingPositionEvent();

  @override
  List<Object> get props => [];
}

class JumpingPositionMoved extends JumpingPositionEvent {
  final Offset position;
  const JumpingPositionMoved({
    required this.position,
  });

  @override
  List<Object> get props => [position];
}

class JumpingPositionSetTarget extends JumpingPositionEvent {
  final Offset position;
  const JumpingPositionSetTarget({
    required this.position,
  });

  @override
  List<Object> get props => [position];
}
