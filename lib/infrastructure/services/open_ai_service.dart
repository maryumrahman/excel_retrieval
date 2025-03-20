import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String apiKey = "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";
  final String apiUrl = "https://openrouter.ai/api/v1/chat/completions";

  Future<String> processRecipe2({required String extractedTextByOCR }) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo", // Use GPT-4 or GPT-3.5
          "messages": [
            {
              "role": "system",
              "content":
              "You are a helpful assistant that organizes and labels recipe instructions. First clean the data: remove the jumbled text that makes no sense and is not related to recipes, and is just an ocr version of ads , and text from appbars . then organize the recipe text."
            },
            {
              "role": "user",
              "content":
              "Format this recipe with sections: Cutting, Mixing, Assembling, Cooking. Also, replace 'chicken' with 🐔, 'cheese' with 🧀, 'eggs' with 🥚, and 'tomato ketchup' with 🍅. Recipe:\n\n$extractedTextByOCR"
            }
          ],
          "max_tokens": 500,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

       // return data;
        return data["choices"][0]["message"]["content"];
      } else {
        throw Exception("Failed to fetch response ${response.body} ");
      }
    } catch (e) {
rethrow;
    }
  }


  Future<String> processRecipe(String recipeText) async {
    return '';
  }
  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         "Authorization": "Bearer $apiKey",
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode({
  //         "model": "gpt-3.5-turbo", // Use GPT-4 or GPT-3.5
  //         "messages": [
  //           {
  //             "role": "system",
  //             "content":
  //             "You are a helpful assistant that organizes and labels recipe instructions. First clean the data: remove the jumbled text that makes no sense and is not related to recipes, and is just an ocr version of ads , and text from appbars . then organize the recipe text."
  //           },
  //           {
  //             "role": "user",
  //             "content":
  //             "Format this recipe with sections: Cutting, Mixing, Assembling, Cooking. Also, replace 'chicken' with 🐔, 'cheese' with 🧀, 'eggs' with 🥚, and 'tomato ketchup' with 🍅. Recipe:\n\n$recipeText"
  //           }
  //         ],
  //         "max_tokens": 500,
  //       }),
  //     );
  //     debugPrint("response${response}");
  //     debugPrint("${response.runtimeType}");
  //     debugPrint("string ${response.toString()}");
  //     debugPrint("stts ${response.statusCode.toString()}");
  //     debugPrint("bdy ${response.body.runtimeType}");
  //
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       debugPrint("dcode ${data.runtimeType}");
  //       return data;
  //       // return data["choices"][0]["message"]["content"];
  //     } else {
  //       throw Exception("Failed to fetch response ${response.body} ");
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }


  Future<Map<String, dynamic>> makeContentChunks({required String recipeText}) async {
   try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content":
              "Divide this recipe into four sections: Cutting, Mixing, Assembling, and Cooking. "
                  "Return the response in JSON format only. No text, only JSON.\n\n$recipeText"
            }
          ],
          "temperature": 0.2,
        }),
      );
      debugPrint("resp type${response.runtimeType}");
      debugPrint("resp body${response.body}");
    if (response.statusCode == 200) {
      final rawResponse = jsonDecode(response.body);

      final content = rawResponse['choices'][0]['message']['content'];
      debugPrint("content ${ content.runtimeType }");

      // ✅ Extract JSON from the response
      final jsonString = content.replaceAll('```json', '').replaceAll('```', '').trim();

      // ✅ Now decode it properly
      final data = jsonDecode(jsonString);

      debugPrint("decoded type ${data.runtimeType}");
      debugPrint("decoded $data");
      return data;
    } else {
      throw Exception('Failed to process recipe');
    }
  }catch(e){
  rethrow;
  }}


}