import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_beautiful_checklist_exercise/shared/task_provider.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

    return taskProvider.isLoading
        ? const CircularProgressIndicator()
        : ListView.separated(
            itemCount: taskProvider.items.length,
            itemBuilder: (context, index) {
              final item = taskProvider.items[index];
              return Dismissible(
                key: Key(item),
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete),
                ),
                onDismissed: (direction) async {
                  await taskProvider.deleteItem(index);
                  await taskProvider.loadItems();
                },
                child: ListTile(
                  title: Text(taskProvider.items[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          TextEditingController editController = TextEditingController(text: taskProvider.items[index]);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Task bearbeiten'),
                                content: TextField(
                                  autofocus: true,
                                  controller: editController,
                                  decoration: const InputDecoration(hintText: "Task bearbeiten"),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Abbrechen'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Speichern'),
                                    onPressed: () async {
                                      await taskProvider.editItem(index, editController.text);
                                      await taskProvider.loadItems();
                                      if (context.mounted) Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await taskProvider.deleteItem(index);
                          await taskProvider.loadItems();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              thickness: 1,
              color: Colors.white10,
            ),
          );
  }
}
