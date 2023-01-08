//

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../http_upload_service.dart';

part 'image_uploader_state.dart';

class ImageUploaderCubit extends Cubit<ImageUploaderState> {
  // final HttpUploadService _service = HttpUploadService
  ImageUploaderCubit() : super(const ImageUploaderState());

  Future<dynamic> uploadFile(File file) async {
    try {
      emit(state.copyWith(hasStarted: true));
      final response = await HttpUploadService.fileUploadMultipart(
        file: file,
        onUploadProgress: (sentBytes, totalBytes) {
          emit(state.copyWith(percentage: sentBytes * 100 / totalBytes));
        },
      );
      if (response != null) {
        if (response.success) {
          emit(state.copyWith(
              percentage: 0,
              hasEnd: true,
              hasImage: true,
              imagePath: response.data?.image?.url ?? ''));
        } else {
          emit(state.copyWith(
              percentage: 0, hasError: true, error: 'SOme thing'));
        }
      }
    } on Exception catch (ex) {
      print(ex.toString());
      emit(state.copyWith(
          percentage: 0, hasEnd: true, hasError: true, error: ex.toString()));
    }
  }
}
