import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/shared/shared_preferences_repository.dart';

class TaskProvider extends ChangeNotifier {
  final DatabaseRepository taskRepo = SharedPreferencesRepository();
  List<String> _items = [];
  bool isLoading = false;

  int _currentTasksCount = 0;
  int _completedTasksCount = 0;

  List<String> get items => _items;

  Future<void> loadItems() async {
    isLoading = true;
    notifyListeners();
    // await Future.delayed(const Duration(seconds: 2));
    _items = await taskRepo.getItems();
    _currentTasksCount = _items.length;
    _completedTasksCount = await taskRepo.completedTasksCount;

    isLoading = false;
    notifyListeners();
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

  int get completedTasksCount => _completedTasksCount;
  int get currentTaskCount => _currentTasksCount;
}
