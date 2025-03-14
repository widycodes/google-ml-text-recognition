import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_text_recognition/data/services/image_picker_service.dart';
import 'package:google_ml_text_recognition/data/services/text_recognition_service.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

part 'image_processor_state.dart';

class ImageProcessorCubit extends Cubit<ImageProcessorState> {
  final ImagePickerService imagePickerService;
  final TextRecognitionService textRecognitionService;

  ImageProcessorCubit({
    required this.imagePickerService,
    required this.textRecognitionService,
  }) : super(ImageProcessorInitial());

  Future<void> pickImageFromCamera() async {
    emit(IsLoading());
    final File? image = await ImagePickerService().getImageFromCamera();
    if (image != null) {
      emit(ImagePicked(image.path));

      emit(IsLoading());

      final String extractedText = await textRecognitionService
          .recognizeText(InputImage.fromFilePath(image.path));

      emit(
        ImageProcessed(
          image.path,
          extractedText,
        ),
      );
    } else {
      emit(ImageProcessorError('Error picking image from camera'));
    }
  }

  Future<void> pickImageFromGallery() async {
    emit(IsLoading());
    final File? image = await ImagePickerService().getImageFromGallery();
    if (image != null) {
      emit(ImagePicked(image.path));

      emit(IsLoading());

      final String extractedText = await textRecognitionService
          .recognizeText(InputImage.fromFilePath(image.path));

      emit(
        ImageProcessed(
          image.path,
          extractedText,
        ),
      );
    } else {
      emit(ImageProcessorError('Error picking image from Gallery'));
    }
  }
}
