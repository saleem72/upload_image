// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'jumping_position_bloc.dart';

class JumpingPositionState extends Equatable {
  const JumpingPositionState({
    this.position = Offset.zero,
    this.display = false,
    this.target = Offset.zero,
  });

  final Offset position;
  final bool display;
  final Offset target;

  @override
  List<Object> get props => [position, display, target];

  JumpingPositionState copyWith({
    Offset? position,
    bool? display,
    Offset? target,
  }) {
    return JumpingPositionState(
      position: position ?? this.position,
      display: display ?? this.display,
      target: target ?? this.target,
    );
  }
}
