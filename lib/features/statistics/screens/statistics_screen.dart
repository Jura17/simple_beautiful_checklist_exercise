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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().loadCompletedTasksCount();
      context.read<TaskProvider>().loadItemCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.read<TaskProvider>();

    int currentTaskCount = taskProvider.currentTaskCount;
    int completedTasksCount = taskProvider.completedTasksCount;

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
