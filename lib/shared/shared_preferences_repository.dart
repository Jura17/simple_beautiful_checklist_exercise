import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  static const String _tasksKey = "tasks";
  static const String _completedTasksKey = "completedTasks";

  @override
  Future<void> addItem(String item) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> allItems = await getItems();
    allItems.add(item);
    await prefs.setStringList(_tasksKey, allItems);
  }

  @override
  Future<void> deleteItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> allItems = await getItems();
    allItems.removeAt(index);
    await prefs.setStringList(_tasksKey, allItems);
    int completedTasksCounts = prefs.getInt(_completedTasksKey) ?? 0;
    completedTasksCounts++;
    await prefs.setInt(_completedTasksKey, completedTasksCounts);
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> allItems = await getItems();
    allItems[index] = newItem;
    await prefs.setStringList(_tasksKey, allItems);
  }

  @override
  Future<List<String>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_tasksKey) ?? [];
  }

  @override
  Future<int> get itemCount async {
    List<String> allItems = await getItems();
    return allItems.length;
  }

  @override
  Future<int> get completedTasksCount async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_completedTasksKey) ?? 0;
  }
}
