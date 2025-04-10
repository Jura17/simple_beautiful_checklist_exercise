import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_beautiful_checklist_exercise/features/statistics/widgets/task_counter_card.dart';
import 'package:simple_beautiful_checklist_exercise/shared/task_provider.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({
    super.key,
  });

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int currentTasksCount = 0;
  int completedTasksCount = 0;

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.read<TaskProvider>();

    currentTasksCount = taskProvider.currentTaskCount;
    completedTasksCount = taskProvider.completedTasksCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task-Statistik"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            TaskCounterCard(
              taskCount: currentTasksCount,
              infoText: "Anzahl der offenen Tasks",
              shapeColor: Colors.purple,
            ),
            if (completedTasksCount > 0)
              TaskCounterCard(
                taskCount: completedTasksCount,
                infoText: "Abgeschlossene Tasks",
                shapeColor: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}
