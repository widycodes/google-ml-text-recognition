import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_text_recognition/data/cubits/image_processor/image_processor_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Google ML Kit OCR',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: BlocBuilder<ImageProcessorCubit, ImageProcessorState>(
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Container(
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.brown),
                        child: state is ImagePicked
                            ? Image.file(
                                File(state.imagePath),
                                fit: BoxFit.cover,
                              )
                            : state is ImageProcessed
                                ? Image.file(
                                    File(state.imagePath),
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(
                                    Icons.broken_image,
                                    size: 150.0,
                                    color: Colors.white,
                                  ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      if (state is IsLoading)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      Text(
                        state is ImageProcessed
                            ? state.extractedText.isEmpty
                                ? 'No text found'
                                : state.extractedText
                            : state is ImageProcessorError
                                ? 'No image picked'
                                : state is ImageProcessorInitial
                                    ? 'Pick an image to extract text'
                                    : "Loading...",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 8.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 48),
                      IconButton.outlined(
                        onPressed: () {
                          context
                              .read<ImageProcessorCubit>()
                              .pickImageFromCamera();
                        },
                        icon: Icon(Icons.camera_alt),
                        iconSize: 60.0,
                        color: Colors.blueAccent,
                      ),
                      // SizedBox(
                      //   width: 8.0,
                      // ),
                      IconButton.outlined(
                        onPressed: () {
                          context
                              .read<ImageProcessorCubit>()
                              .pickImageFromGallery();
                        },
                        icon: Icon(Icons.image),
                        iconSize: 24.0,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
