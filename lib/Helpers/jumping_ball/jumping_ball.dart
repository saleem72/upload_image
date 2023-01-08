//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'jumping_position_bloc/jumping_position_bloc.dart';

class JumpingBall extends StatefulWidget {
  const JumpingBall({super.key});

  @override
  State<JumpingBall> createState() => _JumpingBallState();
}

class _JumpingBallState extends State<JumpingBall>
    with SingleTickerProviderStateMixin {
  Offset position = Offset.zero;
  Offset target = Offset.zero;

  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;
  late Animation<Offset> _upOffset;
  late Animation<Offset> _downOffset;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _upOffset =
        Tween<Offset>(begin: position, end: target).animate(_curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JumpingPositionBloc, JumpingPositionState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: BlocBuilder<JumpingPositionBloc, JumpingPositionState>(
        builder: (context, state) {
          return ball(offset: state.position);
        },
      ),
    );
  }

  Widget ball({required Offset offset}) {
    return Transform.translate(
      offset: offset,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, right: 32),
        // padding: const EdgeInsets.all(12),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              // offset: const Offset(4, 4),
              blurRadius: 3,
            )
          ],
        ),
        alignment: Alignment.center,
        child: const FaIcon(
          FontAwesomeIcons.cartPlus,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}

class _InnerBall extends StatelessWidget {
  const _InnerBall({
    Key? key,
    required this.offset,
  }) : super(key: key);
  final Offset offset;
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, right: 32),
        // padding: const EdgeInsets.all(12),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              // offset: const Offset(4, 4),
              blurRadius: 3,
            )
          ],
        ),
        alignment: Alignment.center,
        child: const FaIcon(
          FontAwesomeIcons.cartPlus,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
