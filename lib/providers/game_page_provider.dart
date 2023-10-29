import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();

  late List _questions;
  List get questions => _questions;

  final int _maxQuestions = 10;
  late int _currentQuestion;
  late String _difficultyLevel;

  late int _correctCount;
  int get correctCount => _correctCount;

  late bool _end;
  bool get end => _end;

  GamePageProvider({required String difficulty}) {
    _difficultyLevel = difficulty.toLowerCase();
    _init();
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestions();
  }

  void _init() {
    _questions = [];
    _correctCount = 0;
    _end = false;
    _currentQuestion = 0;
  }

  Future<void> _getQuestions() async {
    var response = await _dio.get('', queryParameters: {
      'amount': _maxQuestions,
      'type': 'boolean',
      'difficulty': _difficultyLevel,
    });

    _questions = response.data['results'];

    // print(questions);
    notifyListeners();
  }

  void startOver() {
    _init();
    notifyListeners();
    _getQuestions();
  }

  String getCurrentQuestion() =>
      _questions[_currentQuestion]['question'].toString();

  bool checkAnswer(String answer) {
    bool isCorrect = _questions[_currentQuestion]['correct_answer'] == answer;
    if (isCorrect) {
      _correctCount++;
    }
    return isCorrect;
  }

  void getNext() {
    _end = _currentQuestion == _maxQuestions - 1;
    if (!_end) _currentQuestion++;
    notifyListeners();
  }

  // void endGame() => _end = true;
}
