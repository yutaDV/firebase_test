import 'package:cloud_firestore/cloud_firestore.dart';

class Word {
  final String id;
  final String word;
  final String language;
  final int difficulty;
  final String description;

  Word({
    required this.id,
    required this.word,
    required this.language,
    required this.difficulty,
    required this.description,
  });

  factory Word.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Word(
      id: doc.id,
      word: data['word'] ?? '',
      language: data['language'] ?? '',
      difficulty: data['difficulty'] ?? 2, // Рівень складності за замовчуванням
      description: data['description'] ?? '',
    );
  }
}

Word newWord = Word(
id: '', // може бути порожнім
word: 'світ',
language: 'uk',
difficulty: 1,
  description: '',

); // Рівень складності
