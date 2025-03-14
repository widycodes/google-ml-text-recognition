// import 'dart:io';

part of 'image_processor_cubit.dart';

class ImageProcessorState {}

class ImageProcessorInitial extends ImageProcessorState {}

class IsLoading extends ImageProcessorState {}

class ImagePicked extends ImageProcessorState {
  final String imagePath;

  ImagePicked(this.imagePath);
}

class ImageProcessed extends ImageProcessorState {
  final String imagePath;
  final String extractedText;

  ImageProcessed(this.imagePath, this.extractedText);
}

class ImageProcessorError extends ImageProcessorState {
  final String message;

  ImageProcessorError(this.message);
}
