import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tralalala',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tralalala'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Guessable {
  final String sing;
  final String guess;
  final String artist;
  final String songTitle;

  Guessable(this.sing, this.guess, this.artist, this.songTitle);
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _correctAnswersT1 = 0;
  int _correctAnswersT2 = 0;
  bool _teamTurn = true;
  List<Guessable> listTab = [
    Guessable("Lean a little bit closer, see",
        "Roses really smell like poo-poo-ooh", "Outkast", "Roses"),
    Guessable("Mamma mia, here I go again", "My my, how can I resist you?",
        "ABBA", "Mamma Mia"),
    Guessable("Tra la li", "asd", "Marcus", "songTitle")
  ];

  void _correctGuess() {
    setState(() {
      print("hej: $_teamTurn");
      if(_teamTurn) {
        _correctAnswersT1++;
      } else {
        _correctAnswersT2++;
      }
    });
    _goToNextSong();
  }

  void _incorrectGuess() {
    _goToNextSong();
  }

  void _goToNextSong() {
    setState(() {
      _teamTurn = !_teamTurn;
      if (_counter + 1 == listTab.length) {
        _counter = 0;
      } else {
        _counter++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentGuess = listTab[_counter];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              child: Column(
                children: [
                  FittedBox(
                      fit: BoxFit.fitWidth, child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Team 1 correct: $_correctAnswersT1",
                            style:
                            Theme.of(context).textTheme.headline3?.copyWith(
                              color: Colors.red[300],
                            ),
                        ),
                      )),
                  FittedBox(
                      fit: BoxFit.fitWidth, child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Team 2 correct: $_correctAnswersT2", style:
                    Theme.of(context).textTheme.headline3?.copyWith(
                      color: Colors.blue[300],
                    )),
                  )),
                ],
              ),
            ),
            Card(
              elevation: 2.0,
              color: _teamTurn ? Colors.red[100] : Colors.blue[100],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    FittedBox(
                        fit: BoxFit.fitWidth, child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Team " + (_teamTurn ? "1" : "2") + " guessing",
                        style:
                        Theme.of(context).textTheme.headline5?.copyWith(
                          color: _teamTurn ? Colors.red[900] : Colors.blue[900],
                        ),
                      ),
                    )),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(currentGuess.sing,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.headline3?.copyWith(
                                      color: Colors.deepOrangeAccent,
                                    )),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(currentGuess.guess,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline3),
                      ),
                    ),
                    Center(
                      child: Row(
                        children: [
                          Text(currentGuess.artist,
                              style: Theme.of(context).textTheme.headline5),
                          Text(" - ",
                              style: Theme.of(context).textTheme.headline5),
                          Text(currentGuess.songTitle,
                              style: Theme.of(context).textTheme.headline5)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: TextButton.icon(
                        icon: const Icon(Icons.close),
                        label: const Text("Miss"),
                        onPressed: () {
                          _incorrectGuess();
                        })),
                Expanded(
                    child: TextButton.icon(
                        icon: const Icon(Icons.check),
                        label: const Text("Hit"),
                        onPressed: () {
                          _correctGuess();
                        }))
              ],
            )
          ],
        ),
      ),
    );
  }
}
