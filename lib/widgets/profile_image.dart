//

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:upload_image/Helpers/image_upload/cubit/image_uploader_cubit.dart';
import 'package:upload_image/Helpers/image_upload/progress_circle.dart';

import '../styling/styling.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    Key? key,
    required this.pictureSize,
    this.url,
  }) : super(key: key);
  final double pictureSize;
  final String? url;
  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageUploaderCubit, ImageUploaderState>(
      builder: (context, state) {
        return _content(context, state);
      },
    );
  }

  GestureDetector _content(BuildContext context, ImageUploaderState state) {
    return GestureDetector(
      onTap: () => _uploadImage(context),
      child: Stack(
        children: [
          Container(
            width: widget.pictureSize,
            height: widget.pictureSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Pallet.accentColor,
                width: 5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              image: DecorationImage(image: _image(state), fit: BoxFit.cover),
            ),
          ),
          if (state.hasStarted)
            ProgressCircle(
              progress: state.percentage,
              size: widget.pictureSize,
              outlineThikness: 5,
              hasEnd: state.hasEnd,
            ),
        ],
      ),
    );
  }

  ImageProvider<Object> _image(ImageUploaderState state) {
    if (state.hasImage) {
      final path = state.imagePath;
      return Image.network(
        path,
        loadingBuilder: (context, child, loadingProgress) => const Center(
          child: SizedBox(
            width: 44,
            height: 44,
            child: CircularProgressIndicator(),
          ),
        ),
        errorBuilder: (context, error, stackTrace) =>
            const FaIcon(FontAwesomeIcons.image),
        fit: BoxFit.cover,
      ).image;
    } else if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return Image.file(
        File(path),
        fit: BoxFit.cover,
      ).image;
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return Image.file(File(path)).image;
    } else if (widget.url != null) {
      final path = widget.url!;
      return Image.network(
        path,
        loadingBuilder: (context, child, loadingProgress) => const Center(
          child: SizedBox(
            width: 44,
            height: 44,
            child: CircularProgressIndicator(),
          ),
        ),
        errorBuilder: (context, error, stackTrace) =>
            const FaIcon(FontAwesomeIcons.image),
        fit: BoxFit.cover,
      ).image;
    } else {
      return Image.asset(Assets.user).image;
    }
  }

  Future<void> _cropImage(BuildContext context) async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Image Uploader',
            toolbarColor: Pallet.accentColor,
            statusBarColor: Pallet.accentColor,
            toolbarWidgetColor: Colors.white,
            backgroundColor: Pallet.lightBk,
            activeControlsWidgetColor: Pallet.accentColor,
            // dimmedLayerColor: Pallet.lightBk,
            cropFrameColor: Colors.purple,
            cropGridColor: Colors.purple,

            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Image Uploader',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
          _saveImage(context);
        });
      }
    }
  }

  Future<String?> _saveImage(BuildContext context) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    // final String path = directory.path;
    final id = '${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
    final String newImagePath = path.join(directory.path, 'images', id);

    final bytes = await _croppedFile?.readAsBytes();
    if (bytes != null) {
      final File file = File(newImagePath);
      await file.create(recursive: true);
      await file.writeAsBytes(bytes);
      if (mounted) {}
      context.read<ImageUploaderCubit>().uploadFile(file);
      // TODO: call Api
      // context.read<ImageUploadCubit>().uploadFile(file);

      // setState(() {
      //   _pickedFile = null; // XFile(newImagePath);
      //   _croppedFile = null;
      // });
      return newImagePath;
    } else {
      return null;
    }
  }

  Future<void> _uploadImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    // imagePicker.
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
        _cropImage(context);
      });
    }
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }
}
