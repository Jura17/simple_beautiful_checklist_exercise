import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/shared/shared_preferences_repository.dart';

class TaskProvider extends ChangeNotifier {
  final DatabaseRepository taskRepo = SharedPreferencesRepository();
  List<String> _items = [];
  bool isLoading = false;
  int _currentTaskCount = 0;
  int _completedTasksCount = 0;

  List<String> get items => _items;

  Future<void> loadItems() async {
    isLoading = true;
    notifyListeners();
    // Future.delayed(Duration(seconds: 2), () async {
    _items = await taskRepo.getItems();
    isLoading = false;
    notifyListeners();
    // });
  }

  Future<void> addItem(String item) async {
    await taskRepo.addItem(item);
  }

  Future<void> deleteItem(int index) async {
    await taskRepo.deleteItem(index);
  }

  Future<void> editItem(int index, String newItem) async {
    await taskRepo.editItem(index, newItem);
  }

  Future<void> loadCompletedTasksCount() async {
    _completedTasksCount = await taskRepo.completedTasksCount;
  }

  int get completedTasksCount => _completedTasksCount;

  void loadItemCount() async {
    if (_currentTaskCount != items.length) {
      _currentTaskCount = items.length;
      notifyListeners();
    }
  }

  int get currentTaskCount => _currentTaskCount;
}
