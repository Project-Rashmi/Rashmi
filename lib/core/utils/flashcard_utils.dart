import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rashmi/core/constants.dart';

//QuizData quiz = QuizData.fromJson(jsonString as Map<String, dynamic>);

final jsonData = jsonDecode(jsonString);
QuizData quiz = QuizData.fromJson(jsonData);


class McqModel {

  int currentMcqIndex = 1; 
  late Mcq currentMcq;

  Mcq? onFrontMCQClicked() {
    if (currentMcqIndex < quiz.mcqs.length) {
      currentMcq = quiz.mcqs[currentMcqIndex];
      currentMcqIndex++;
      return currentMcq;
    }
      return null;
  }

  void onBackMCQClicked() {
    currentMcqIndex--;
  }

}

class FlashcardModel {

  int currentFlashcardIndex = 1;
  late Flashcard currentFlashCard;

  Flashcard? onFrontMCQClicked() {
    if (currentFlashcardIndex >= quiz.flashcards.length) {
      if (kDebugMode) {
        print("null phyalyo yaar");
      }
      return null;
    }
    if (currentFlashcardIndex < quiz.flashcards.length) {
      currentFlashCard = quiz.flashcards[currentFlashcardIndex];
      currentFlashcardIndex++;
      return currentFlashCard;
    } 
      return null;
  }

  void onBackMCQClicked() {
    currentFlashcardIndex--;
  }

}