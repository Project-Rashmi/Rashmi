import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FlashcardService {
  final String baseUrl = 'https://needed-narwhal-charmed.ngrok-free.app/card/deck';
  final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbjExIiwiZXhwIjoxNzM4MTU3NTEwLCJpYXQiOjE3Mzc1NTc1MTB9.sJcG5H-1iAAiaoeYmfCoWSl9l8FnFQQvM3UVHYURx18';

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
