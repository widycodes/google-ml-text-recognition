import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_text_recognition/data/services/image_picker_service.dart';

part 'image_picker.state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  final ImagePickerService imagePickerService;

  ImagePickerCubit({required this.imagePickerService})
      : super(ImagePickerInitial());

  Future<void> pickImageFromCamera() async {
    emit(IsPickingImage());
    final File? image = await ImagePickerService().getImageFromCamera();
    if (image != null) {
      emit(ImagePicked(image.path));
    } else {
      emit(ErrorPickingImage('Error picking image from camera'));
    }
  }

  Future<void> pickImageFromGallery() async {
    emit(IsPickingImage());
    final File? image = await ImagePickerService().getImageFromGallery();
    if (image != null) {
      emit(ImagePicked(image.path));
    } else {
      emit(ErrorPickingImage('Error picking image from Gallery'));
    }
  }
}
