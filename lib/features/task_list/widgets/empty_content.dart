import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    super.key,
    required this.repository,
  });

  final DatabaseRepository repository;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.sentiment_satisfied_alt, size: 64),
          SizedBox(height: 10),
          Text('Alle Aufgaben erledigt'),
        ],
      ),
    );
  }
}
