import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/test_history_model.dart';

class TestHistoryRepository {
  static const String key = "careeros_test_history";

  Future<void> save(
      TestHistoryModel history) async {
    final prefs =
        await SharedPreferences.getInstance();

    List<String> list =
        prefs.getStringList(key) ?? [];

    list.insert(
      0,
      jsonEncode(history.toJson()),
    );

    await prefs.setStringList(key, list);
  }

  Future<List<TestHistoryModel>> getAll() async {
    final prefs =
        await SharedPreferences.getInstance();

    List<String> list =
        prefs.getStringList(key) ?? [];

    return list
        .map(
          (e) => TestHistoryModel.fromJson(
            jsonDecode(e),
          ),
        )
        .toList();
  }

  Future<void> clear() async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(key);
  }
}