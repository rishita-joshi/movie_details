import 'package:flutter/material.dart';

enum ViewType { grid, list }

class ListProvider extends ChangeNotifier {
  bool _isGridView = false;
  int crossAxisCount = 2;
  double aspectRatio = 1.5;
  ViewType _viewType = ViewType.grid;

  bool get isGridView => _isGridView;

  changeViewType() {
    if (_viewType == ViewType.list) {
      crossAxisCount = 2;
      aspectRatio = 1.5;
      _viewType = ViewType.grid;
    } else {
      crossAxisCount = 1;
      aspectRatio = 5;
      _viewType = ViewType.list;
    }

    notifyListeners();
  }

  changeToggle() {
    _isGridView = !isGridView;
    notifyListeners();
  }
}
