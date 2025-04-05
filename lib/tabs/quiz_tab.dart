import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizTab extends StatefulWidget {
  const QuizTab({super.key});

  @override
  State<QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<QuizTab> {
  final List<String> _letters =
      List.generate(26, (i) => String.fromCharCode(65 + i)); // A-Z
  final List<String> _numbers = List.generate(10, (i) => '$i'); // 0-9
  late List<String> _questions;
  int _currentIndex = 0;
  int _score = 0;
  bool _quizFinished = false;

  @override
  void initState() {
    super.initState();
    _generateQuiz();
  }

  void _generateQuiz() {
    final allItems = [..._letters, ..._numbers];
    allItems.shuffle();
    _questions = allItems.take(10).toList();
  }

  void _checkAnswer(String selected) {
    if (selected == _questions[_currentIndex]) {
      _score++;
    }

    if (_currentIndex < 9) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _saveScore(_score);
      setState(() {
        _quizFinished = true;
      });
    }
  }

  void _saveScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final scores = prefs.getStringList('quiz_scores') ?? [];
    scores.add(score.toString());
    await prefs.setStringList('quiz_scores', scores);
  }

  List<String> _generateOptions(String correct) {
    final all = [..._letters, ..._numbers];
    all.remove(correct);
    all.shuffle();
    final options = all.take(3).toList()..add(correct);
    options.shuffle();
    return options;
  }

  @override
  Widget build(BuildContext context) {
    if (_quizFinished) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Quiz Completed!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Your Score: $_score / 10',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _score = 0;
                  _currentIndex = 0;
                  _quizFinished = false;
                  _generateQuiz();
                });
              },
              child: const Text('Retry Quiz'),
            )
          ],
        ),
      );
    }

    final currentQ = _questions[_currentIndex];
    final options = _generateOptions(currentQ);
    final imagePath = 'assets/images2/${currentQ.toLowerCase()}.png';

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Question ${_currentIndex + 1} of 10',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text('Identify This:', style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          Container(
            height: 150,
            child: Image.asset(
              imagePath,
              errorBuilder: (context, error, stackTrace) {
                return const Text("Image not found");
              },
            ),
          ),
          const SizedBox(height: 30),
          ...options.map((opt) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => _checkAnswer(opt),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50)),
                  child: Text(opt, style: const TextStyle(fontSize: 20)),
                ),
              )),
        ],
      ),
    );
  }
}
