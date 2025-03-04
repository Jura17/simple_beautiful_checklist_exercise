import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/features/statistics/widgets/task_counter_card.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({
    super.key,
    required this.repository,
  });

  final DatabaseRepository repository;

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int currentTaskCount = 0;
  int currentCompletedTasksCount = 0;

  void loadItemCount() async {
    int taskCount = await widget.repository.itemCount;

    if (taskCount != currentTaskCount) {
      setState(() {
        currentTaskCount = taskCount;
      });
    }
  }

  void loadCompletedTasksCount() async {
    int completedTasksCount = await widget.repository.completedTasksCount;

    if (completedTasksCount != currentCompletedTasksCount) {
      setState(() {
        currentCompletedTasksCount = completedTasksCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    loadItemCount();
    loadCompletedTasksCount();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task-Statistik"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            TaskCounterCard(
              taskCount: currentTaskCount,
              infoText: "Anzahl der offenen Tasks",
              shapeColor: Colors.purple,
            ),
            if (currentCompletedTasksCount > 0)
              TaskCounterCard(
                taskCount: currentCompletedTasksCount,
                infoText: "Abgeschlossene Tasks",
                shapeColor: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}
