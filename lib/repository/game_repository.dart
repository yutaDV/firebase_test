import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/game.dart';

class GameRepository {
  final CollectionReference gamesCollection =
  FirebaseFirestore.instance.collection('games');

  Future<String> createGame(
      String accessCode, String gameType, String firstPlayerName) async {
    try {
      // Створіть об'єкт гри з переданими параметрами
      final newGame = GameModel(
        status: 'New',
        accessCode: accessCode,
        gameType: gameType,
        players: [
          PlayerModel.defaultPlayer(
            playerName: firstPlayerName,
            playerStatus: 'first',
          ),
        ],
        round: 0, // Початковий раунд
      );

      // Додайте гру до колекції і конвертуйте об'єкт гри в Map
      final DocumentReference gameDocRef = await gamesCollection.add({
        'status': newGame.status,
        'accessCode': newGame.accessCode,
        'gameType': newGame.gameType,
        'round': newGame.round,
        'players': newGame.players
            .map((player) => {
          'name': player.name,
          'playerNumber': player.playerNumber,
          'role': player.role,
          'playerStatus': player.playerStatus,
          'totalScore': player.totalScore,
          'rounds': player.rounds
              .map((round) => {
            'roundNumber': round.roundNumber,
            'correctWords': ['тут будуть коректні слова'],
            'incorrectWords': ['тут будуть некоректні слова'],
            'roundScore': round.roundScore,
          })
              .toList(),
        })
            .toList(),
      });

      // Повернути ідентифікатор створеної гри
      return gameDocRef.id;
    } catch (e) {
      // Обробіть помилку, якщо виникла
      throw Exception('Помилка при створенні гри: $e');
    }
  }

  Future<void> addPlayerToGame(String accessCode, String playerName) async {
    try {
      // Знайдіть гру з вказаним accessCode та статусом "New"
      final QuerySnapshot querySnapshot = await gamesCollection
          .where('accessCode', isEqualTo: accessCode)
          .where('status', isEqualTo: 'New')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot gameDoc = querySnapshot.docs.first;
        final List<dynamic> playersList = gameDoc['players'];

        // Знайдіть максимальний порядковий номер гравця у грі
        int maxPlayerNumber = 0;
        for (final playerData in playersList) {
          final int playerNumber = playerData['playerNumber'];
          if (playerNumber > maxPlayerNumber) {
            maxPlayerNumber = playerNumber;
          }
        }

        // Додайте нового гравця до гри з необхідними параметрами
        final PlayerModel newPlayer = PlayerModel(
          name: playerName,
          playerNumber: maxPlayerNumber + 1, // Наступний порядковий номер
          role: 'очікує',
          playerStatus: 'інший',
          totalScore: 0,
          rounds: [
            RoundModel(
              roundNumber: 0,
              correctWords: ['тут будуть коректні слова'],
              incorrectWords: ['тут будуть некоректні слова'],
              roundScore: 0,
            ),
          ],
        );

        // Оновіть список гравців у грі
        playersList.add(newPlayer.toMap()); // Перетворити об'єкт гравця у Map та додати до списку

        // Оновіть документ гри з оновленими даними
        await gameDoc.reference.update({
          'players': playersList,
        });
      } else {
        throw Exception('Гра не знайдена або не може бути змінена.');
      }
    } catch (e) {
      throw Exception('Помилка під час додавання гравця до гри: $e');
    }
  }


// Додайте інші методи для оновлення, видалення і іншої роботи з грою за потреби
}
