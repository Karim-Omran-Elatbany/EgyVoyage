import 'dart:convert';



import 'package:egyvoyage/Home_view/features/chat-bot/presentation/api/api_key.dart';
import 'package:egyvoyage/Home_view/features/chat-bot/presentation/data/chat_model.dart';
import 'package:http/http.dart' as http;
Future<ChatModel> sendRequestToGemini(ChatModel model) async {
  String url = "";
  Map<String, dynamic> body = {};

  if (model.base64EncodedImage == null) {
    url =
    "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${GeminiApiKey.api_key}";
    //http.post(url)
    body = {
      "contents": [
        {
          "parts": [
            {"text": model.message},
          ],
        },
      ],
    };
  } else {
    url =
    "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro-vision:generateContent?key=${GeminiApiKey.api_key}";

    body = {
      "contents": [
        {
          "parts": [
            {"text": model.message},
            {
              "inline_data": {
                "mime_type": "image/jpeg",
                "data": model.base64EncodedImage,
              }
            }
          ],
        },
      ],
    };
  }

  Uri uri = Uri.parse(url);

  final result = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );

  print(result.statusCode);
  print(result.body);

  final decodedJson = json.decode(result.body);

  String message =
  decodedJson["candidates"][0]["content"]["parts"][0]["text"];

  ChatModel geminiModel = ChatModel(isMe: false, message: message);

  return geminiModel;
}