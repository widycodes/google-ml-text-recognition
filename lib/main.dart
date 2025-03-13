import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_text_recognition/data/services/image_picker_service.dart';
import 'package:google_ml_text_recognition/presentation/screens/home_page.dart';
import 'package:google_ml_text_recognition/data/cubits/image_picker/image_picker_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OCR App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => ImagePickerCubit(
          imagePickerService: ImagePickerService(),
        ),
        child: const HomePage(),
      ),
    );
  }
}
