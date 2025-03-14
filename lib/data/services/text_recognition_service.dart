import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognitionService {
  Future<String> recognizeText(InputImage inputImage) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    textRecognizer.close();

    // await Future.delayed(Duration(seconds: 2));

    return recognizedText.text;
  }
}
