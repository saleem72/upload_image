// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:upload_image/Helpers/image_upload/cubit/image_uploader_cubit.dart';

import 'package:upload_image/styling/assets.dart';
import 'package:upload_image/styling/pallet.dart';

import '../widgets/profile_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageUploaderCubit(),
      child: const ProfileScreenContent(),
    );
  }
}

class ProfileScreenContent extends StatelessWidget {
  const ProfileScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pictureSize = size.width * 0.6;
    final bioSectionHeight = size.height * 0.6;
    final leftOverHeight = size.height * 0.4;
    const double buttonSize = 44.0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Pallet.lightBk,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          _skyScraper(),
          _bio(bioSectionHeight, size, pictureSize, context),
          _profileImage(pictureSize, leftOverHeight),
          _addButton(pictureSize, leftOverHeight, buttonSize),
        ],
      ),
    );
  }

  Widget _profileImage(double pictureSize, double leftOverHeight) {
    return Transform.translate(
      offset: Offset(
        -pictureSize * 0.2,
        leftOverHeight - pictureSize * 0.5,
      ),
      child: ProfileImage(
        pictureSize: pictureSize,
        url: 'https://i.ibb.co/bstGz5W/1672836059221.jpg',
      ),
    );
  }

  Widget _addButton(
      double pictureSize, double leftOverHeight, double buttonSize) {
    return Transform.translate(
      offset: Offset(
        pictureSize * 1.25,
        leftOverHeight - buttonSize * 0.5,
      ),
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Pallet.accentColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          size: 24,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _bio(double bioSectionHeight, Size size, double pictureSize,
      BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: bioSectionHeight,
        width: size.width,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Pallet.darkBK,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            CustomPaint(
              size: Size.infinite,
              painter: SingleRoundedCorner(
                radius: 20,
                color: Pallet.accentColor,
                strokeWidth: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 16),
              child: _bioContents(pictureSize, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bioContents(double pictureSize, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: pictureSize * 0.5 + 16),
          Text(
            'Jhon Deo',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white, letterSpacing: 1.2),
          ),
          Text(
            'jhondoe@gmail.com',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
          ),
          Text(
            'Designer',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
          ),
          _socialButtons(),
          Text(
            'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                InfoColumn(
                  value: '69',
                  label: 'Projects',
                ),
                InfoColumn(
                  value: '15K',
                  label: 'Followers',
                ),
                InfoColumn(
                  value: '279',
                  label: 'Following',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.instagram,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: _facebookIcon(),
        ),
        IconButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.linkedinIn,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.globe,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.twitter,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _facebookIcon() {
    return Stack(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.white,
            width: 2,
          )),
        ),
        const Positioned(
          bottom: 4,
          right: 4,
          child: FaIcon(
            FontAwesomeIcons.facebookF,
            size: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _skyScraper() {
    return Transform.translate(
      offset: const Offset(120, -80),
      child: Image.asset(
        Assets.skyscraper,
        fit: BoxFit.cover,
      ),
    );
  }
}

class InfoColumn extends StatelessWidget {
  const InfoColumn({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
        ),
      ],
    );
  }
}

class SingleRoundedCorner extends CustomPainter {
  final double radius;
  final Paint painter;
  SingleRoundedCorner({
    required this.radius,
    required Color color,
    required double strokeWidth,
  }) : painter = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth * 2;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _innerPath(size);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Path _innerPath(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height);
    return path;
  }
}
