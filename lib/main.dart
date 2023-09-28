import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/game.dart';
import 'models/word.dart';
import 'repository/word_repository.dart';
import 'repository/game_repository.dart';
import 'controller/word_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final WordRepository _wordRepository = WordRepository();
  final GameRepository _gameRepository = GameRepository();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline6,
            ),
            ElevatedButton(
              onPressed: () async {
                _gameRepository.addPlayerToGame('2222', 'варвара');
              },
              child: Text('Додати гравця'),
            ),
            ElevatedButton(
              onPressed: () async {
                _wordRepository.addWord(newWord);
              },
              child: Text('додати слово'),
            ),
            ElevatedButton(
              onPressed: () async {
                final words = await _wordRepository.getWords(language: 'uk', difficulty: 3);
                PrintUtils.printWords(words);
              },
              child: Text('отримати слова'),
            ),
            ElevatedButton(
              onPressed: () async {
                _gameRepository.createGame('2222', 'gameType',  'Nino');
              },
              child: Text('створити гру'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
