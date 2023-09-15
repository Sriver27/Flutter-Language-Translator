import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslatorApi {
  final String baseUrl =
      'https://google-translate1.p.rapidapi.com/language/translate/v2';
  final String API_KEY = '41edbc4562msh5a92e33bdb8fb75p145b6ejsn54c9cd5f81cb';

  Future<Map<String, dynamic>> fetchLanguages() async {
    final response = await http.get(
      Uri.parse('$baseUrl/languages'),
      headers: {
        'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com',
        'X-RapidAPI-Key': API_KEY,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load languages');
    }
  }

  Future<Map<String, dynamic>> translateText(
    String text,
    String sourceLang,
    String targetLang,
  ) async {
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com',
        'Accept-Encoding': 'application/gzip',
        'X-RapidAPI-Key': API_KEY,
      };

      final Map<String, String> body = {
        'q': text,
        'source': sourceLang,
        'target': targetLang,
      };

      final Uri uri = Uri.parse(
          'https://google-translate1.p.rapidapi.com/language/translate/v2');

      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error Response: ${response.body}');
        print('Status Code: ${response.statusCode}');
        throw Exception('Failed to translate text');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
