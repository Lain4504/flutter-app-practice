import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];

  MyAppState() {
    _loadFavorites();
  }

  void _loadFavorites() async {
    favorites = await DatabaseHelper().getFavorites();
    notifyListeners();
  }

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() async {
    if (favorites.contains(current)) {
      favorites.remove(current);
      await DatabaseHelper().deleteFavorite(current);
    } else {
      favorites.add(current);
      await DatabaseHelper().insertFavorite(current);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) async {
    favorites.remove(pair);
    await DatabaseHelper().deleteFavorite(pair);
    notifyListeners();
  }
}
