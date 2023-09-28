import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/word.dart';

class WordRepository {
  final CollectionReference wordsCollection =
  FirebaseFirestore.instance.collection('words');

  Future<List<Word>> getWords({String? language, int? difficulty}) async {
    try {
      Query query = wordsCollection;

      // Додаємо фільтри, якщо параметри вказані
      if (language != null) {
        query = query.where('language', isEqualTo: language);
      }

      if (difficulty != null) {
        query = query.where('difficulty', isEqualTo: difficulty);
      }

      QuerySnapshot querySnapshot = await query.get();

      final List<Word> words = querySnapshot.docs
          .map((doc) => Word.fromDocument(doc))
          .toList();

      return words;
    } catch (e) {
      // Обробіть помилку, якщо виникла
      throw Exception('Помилка при отриманні слів: $e');
    }
  }



  Future<void> addWord(Word word) async {
    try {
      // Отримуємо посилання на колекцію слів у Firestore
      CollectionReference wordsCollection = FirebaseFirestore.instance.collection('words');

      // Додаємо нове слово до колекції, конвертуючи об'єкт Word в Map
      await wordsCollection.add({
        'word': word.word,
        'language': word.language,
        'description': word.description,
        'difficulty': word.difficulty,
      });

      // Успішно додано слово
      print('Слово "${word.word}" успішно додано до бази даних.');
    } catch (e) {
      // Обробка помилки, якщо виникла
      print('Помилка при додаванні слова: $e');
    }
  }

  Future<void> updateWord(Word word) async {
    //  оновлення слова в Firestore
  }

  Future<void> deleteWord(String wordId) async {
    // видалення слова з Firestore
  }
}
