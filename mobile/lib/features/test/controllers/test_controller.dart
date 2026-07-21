import 'dart:async';

import 'package:flutter/material.dart';

import '../models/question_model.dart';
import '../repositories/test_repository.dart';

class TestController extends ChangeNotifier {
  final TestRepository _repository = TestRepository();

  List<QuestionModel> _questions = [];

  List<QuestionModel> get questions => _questions;

  bool _loading = true;
  bool get loading => _loading;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  int _remainingSeconds = 0;
  int get remainingSeconds => _remainingSeconds;

  Timer? _timer;

  Future<void> startTest({
    required String category,
    required int stage,
    required int totalQuestions,
    required int duration,
  }) async {
   try {
    _loading = true;
    notifyListeners();

    _questions = await _repository.generateTest(
      category: category,
      stage: stage,
      totalQuestions: totalQuestions,
    );
    debugPrint("Questions loaded: ${_questions.length}");
    _currentIndex = 0;

    _remainingSeconds = duration * 60;

    _startTimer();
   } catch (e, s) {
    debugPrint("TEST ERROR: $e");
    debugPrintStack(stackTrace: s);
   } finally {
    _loading = false;

    notifyListeners();
   }
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
          notifyListeners();
        } else {
          _timer?.cancel();
        }
      },
    );
  }

  QuestionModel get currentQuestion =>
      _questions[_currentIndex];

  void selectAnswer(int index) {
    currentQuestion.selectedAnswer = index;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void jumpToQuestion(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  String get formattedTime {
    final m =
        (_remainingSeconds ~/ 60).toString().padLeft(2, '0');

    final s =
        (_remainingSeconds % 60).toString().padLeft(2, '0');

    return "$m:$s";
  }

  int get answered =>
      _questions.where((e) => e.selectedAnswer != null).length;
    int get unanswered =>
      _questions.length - answered;

  double get progress {
    if (_questions.isEmpty) return 0;
    return (_currentIndex + 1) / _questions.length;
  }

  int get correct {
    int count = 0;

    for (final q in _questions) {
      if (q.selectedAnswer == q.correctAnswer) {
        count++;
      }
    }

    return count;
  }

  int get wrong {
    int count = 0;

    for (final q in _questions) {
      if (q.selectedAnswer != null &&
          q.selectedAnswer != q.correctAnswer) {
        count++;
      }
    }

    return count;
  }

  int get percentage {
    if (_questions.isEmpty) return 0;

    return ((correct / _questions.length) * 100)
        .round();
  }

  bool get isFirstQuestion =>
      _currentIndex == 0;

  bool get isLastQuestion =>
      _currentIndex ==
      _questions.length - 1;

  bool get isTimeUp =>
       _questions.isNotEmpty && _remainingSeconds <= 0;

  List<bool> get answeredStatus =>
      _questions
          .map(
            (q) =>
                q.selectedAnswer != null,
          )
          .toList();

  void stopTimer() {
    _timer?.cancel();
  }

  void reset() {
    stopTimer();

    _questions.clear();

    _currentIndex = 0;

    _remainingSeconds = 0;

    _loading = true;

    notifyListeners();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }
}