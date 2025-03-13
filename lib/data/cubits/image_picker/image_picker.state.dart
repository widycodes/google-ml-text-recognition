// import 'dart:io';

part of 'image_picker_cubit.dart';

class ImagePickerState {}

class ImagePickerInitial extends ImagePickerState {}

class IsPickingImage extends ImagePickerState {}

class ImagePicked extends ImagePickerState {
  final String imagePath;

  ImagePicked(this.imagePath);
}

class ErrorPickingImage extends ImagePickerState {
  final String message;

  ErrorPickingImage(this.message);
}
