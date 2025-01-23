import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FlashcardService {
  final String baseUrl = 'https://needed-narwhal-charmed.ngrok-free.app/card/deck';
  final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJsb2wiLCJleHAiOjE3MzgxNzQ1MDEsImlhdCI6MTczNzU3NDUwMX0.4jWHwZzQF2EVarvkS8EDAAV7qpCIAm-DNbGUN_qF5qY';

  Future<Map<String, dynamic>> getFlashcards(int deckId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$deckId/flashcards'),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (kDebugMode) {
      print('Response Status: ${response.statusCode}');
    }

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load flashcards: ${response.statusCode}');
    }
  }
}

class FlashcardRandomService {
  final String baseUrl = 'https://needed-narwhal-charmed.ngrok-free.app/card/random/flashcards';
  final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJsb2wiLCJleHAiOjE3MzgxNzQ1MDEsImlhdCI6MTczNzU3NDUwMX0.4jWHwZzQF2EVarvkS8EDAAV7qpCIAm-DNbGUN_qF5qY';

  Future<Map<String, dynamic>> getFlashcards() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (kDebugMode) {
      print('Response Status: ${response.statusCode}');
    }

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load flashcards: ${response.statusCode}');
    }
  }
}
