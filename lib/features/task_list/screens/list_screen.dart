import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_beautiful_checklist_exercise/features/task_list/widgets/empty_content.dart';
import 'package:simple_beautiful_checklist_exercise/features/task_list/widgets/item_list.dart';

import 'package:simple_beautiful_checklist_exercise/shared/task_provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({
    super.key,
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Meine Checkliste'),
        ),
        body: Consumer<TaskProvider>(builder: (context, value, child) {
          return taskProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: value.items.isEmpty ? const EmptyContent() : ItemList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Task Hinzufügen',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () async {
                              if (_controller.text.isNotEmpty) {
                                await taskProvider.addItem(_controller.text);
                                taskProvider.loadItems();
                                _controller.clear();
                              }
                            },
                          ),
                        ),
                        onSubmitted: (value) async {
                          if (value.isNotEmpty) {
                            await taskProvider.addItem(value);
                            taskProvider.loadItems();
                            _controller.clear();
                          }
                        },
                      ),
                    ),
                  ],
                );
        }));
  }
}
