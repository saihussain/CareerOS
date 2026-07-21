import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/question_model.dart';

class TestRepository {
  Future<List<QuestionModel>> generateTest({
    required String category,
    required int stage,
    required int totalQuestions,
  }) async {
    final questions = await _loadQuestions(
      category,
      stage,
    );

    questions.shuffle();

    if (questions.length <= totalQuestions) {
      return questions;
    }

    return questions.take(totalQuestions).toList();
  }

  Future<List<QuestionModel>> _loadQuestions(
    String category,
    int stage,
  ) async {
    final folder = _getFolder(category);

    final jsonString = await rootBundle.loadString(
      'assets/questions/$folder/stage$stage.json',
    );

    final List<dynamic> data = json.decode(jsonString);

    return data
        .map(
          (e) => QuestionModel.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  String _getFolder(String category) {
    switch (category) {
      case "Aptitude":
        return "aptitude";

      case "Programming":
        return "programming";

      case "Problem Solving":
        return "problem_solving";

      default:
        return "aptitude";
    }
  }
}