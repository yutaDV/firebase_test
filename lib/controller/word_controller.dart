import 'package:flutter/material.dart';
import '../models/word.dart';

class PrintUtils {
  static void printWords(List<Word> words) {
    words.forEach((word) {
      print('ID: ${word.id}');
      print('Word: ${word.word}');
      print('Language: ${word.language}');
      print('Description: ${word.description}');
      print('Difficulty: ${word.difficulty}');
      print('---');
    });
  }
}
