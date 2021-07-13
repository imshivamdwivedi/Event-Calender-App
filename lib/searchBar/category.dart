import 'dart:core';

import 'package:flutter/material.dart';

class Category {
  final String name;

  Category({required this.name});
}

class CategoryAPI {
  static List<Category> getUserSuggestion(String query) {
    List<Category> lists = [
      Category(name: 'Cricket'),
      Category(name: 'FootBall'),
      Category(name: 'Badminton'),
      Category(name: 'Investing'),
      Category(name: 'Stocks'),
    ];

    return lists
        .where((category) =>
            category.name.toString().toLowerCase() == query.toLowerCase())
        .toList();
  }
}
