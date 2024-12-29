import 'package:flutter/material.dart';
import 'package:modules/modules.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;

  const TodoItem({
    required this.todo,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(todo.id),
      title: Text(todo.title),
      leading: Checkbox(
        value: todo.completed,
        onChanged: (_) => onToggle(),
      ),
    );
  }
}