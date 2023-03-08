import 'dart:io';

import 'package:dart_openai/openai.dart';

import 'env/env.dart';

import 'package:http/http.dart' as http;

Future<void> main() async {
// Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

// create the audio transcription.
  final translation = OpenAI.instance.audio.createTranslation(
    file: await getFileFromUrl(
      'https://www.cbvoiceovers.com/wp-content/uploads/2017/05/Commercial-showreel.mp3',
    ),
    model: "whisper-1",
  );

  // print the translation.
  print(translation);
}

Future<File> getFileFromUrl(String networkUrl) async {
  final response = await http.get(Uri.parse(networkUrl));
  final uniqueImageName = DateTime.now().microsecondsSinceEpoch;
  final file = File("$uniqueImageName.mp3");
  await file.writeAsBytes(response.bodyBytes);
  return file;
}