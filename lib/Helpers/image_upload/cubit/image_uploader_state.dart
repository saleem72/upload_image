// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'image_uploader_cubit.dart';

class ImageUploaderState extends Equatable {
  final double percentage;
  final bool hasStarted;
  final bool hasEnd;
  final bool hasError;
  final String error;
  final String imagePath;
  final bool hasImage;

  const ImageUploaderState({
    this.percentage = 0,
    this.hasEnd = false,
    this.hasStarted = false,
    this.hasError = false,
    this.error = '',
    this.hasImage = false,
    this.imagePath = '',
  });

  @override
  List<Object?> get props => [
        percentage,
        hasEnd,
        hasError,
        error,
        hasStarted,
        hasImage,
        imagePath,
      ];

  ImageUploaderState copyWith({
    double? percentage,
    bool? hasEnd,
    bool? hasError,
    String? error,
    bool? hasStarted,
    String? imagePath,
    bool? hasImage,
  }) {
    return ImageUploaderState(
      percentage: percentage ?? this.percentage,
      hasEnd: hasEnd ?? this.hasEnd,
      hasError: hasError ?? this.hasError,
      error: error ?? this.error,
      hasStarted: hasStarted ?? this.hasStarted,
      imagePath: imagePath ?? this.imagePath,
      hasImage: hasImage ?? this.hasImage,
    );
  }
}
