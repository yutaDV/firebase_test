class RoundModel {
  int roundNumber; // Порядковий номер раунду
  List<String> correctWords; // Перелік коректних слів
  List<String> incorrectWords; // Перелік некоректних слов
  int roundScore; // Рахунок раунду

  RoundModel({
    required this.roundNumber,
    required this.correctWords,
    required this.incorrectWords,
    required this.roundScore,
  });

  Map<String, dynamic> toMap() {
    return {
      'roundNumber': roundNumber,
      'correctWords': correctWords,
      'incorrectWords': incorrectWords,
      'roundScore': roundScore,
    };
  }

  factory RoundModel.fromMap(Map<String, dynamic> map) {
    return RoundModel(
      roundNumber: map['roundNumber'],
      correctWords: List<String>.from(map['correctWords']),
      incorrectWords: List<String>.from(map['incorrectWords']),
      roundScore: map['roundScore'],
    );
  }
}



class PlayerModel {
  String name;
  int playerNumber;
  String role;
  String playerStatus;
  int totalScore;
  List<RoundModel> rounds;

  PlayerModel({
    required this.name,
    required this.playerNumber,
    required this.role,
    required this.playerStatus,
    required this.totalScore,
    List<RoundModel>? rounds,
  }) : rounds = rounds ?? [];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'playerNumber': playerNumber,
      'role': role,
      'playerStatus': playerStatus,
      'totalScore': totalScore,
      'rounds': rounds.map((round) => round.toMap()).toList(),
    };
  }

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    final roundsList = map['rounds'] != null
        ? List<RoundModel>.from(
        map['rounds'].map((roundMap) => RoundModel.fromMap(roundMap)))
        : <RoundModel>[];

    return PlayerModel(
      name: map['name'],
      playerNumber: map['playerNumber'],
      role: map['role'],
      playerStatus: map['playerStatus'],
      totalScore: map['totalScore'],
      rounds: roundsList,
    );
  }
  // Метод для створення першого гравця з іменем і роллю
  factory PlayerModel.defaultPlayer({
    required String playerName,
    required String playerStatus,
  }) {
    final RoundModel initialRound = RoundModel(
      roundNumber: 0,
      correctWords: ['тут будуть коректні слова'],
      incorrectWords: ['тут будуть некоректні слова'],
      roundScore: 0,
    );

    return PlayerModel(
      name: playerName,
      playerNumber: 1,
      role: 'active',
      totalScore: 0,
      rounds: [initialRound],
      playerStatus: playerStatus, // Додайте параметр playerStatus тут
    );
  }
}


class GameModel {
  String? id; // Ідентифікатор гри (null, оскільки його створює база даних)
  String status; // Статус гри
  String accessCode; // Код доступу до гри
  String gameType; // Тип гри (не змінюватиметься)
  List<PlayerModel> players; // Список гравців гри
  int round; // Поточний раунд

  GameModel({
    required this.status,
    required this.accessCode,
    required this.gameType,
    required this.players,
    required this.round,
  });
}
