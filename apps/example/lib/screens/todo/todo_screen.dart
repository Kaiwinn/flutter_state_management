import 'package:collection/collection.dart';
import 'package:example/models/todo_state.dart';
import 'package:example/screens/todo/widgets/todo_item.dart';
import 'package:example/stores/todo_store.dart';
import 'package:flutter/material.dart';
import 'package:state_mgr/state_mgr.dart';

class TodoScreen extends StatelessWidget {
  final todoStore = TodoStore();
  final _textController = TextEditingController();

  TodoScreen({super.key});

  bool _shouldRebuild(TodoState previous, TodoState current) {
    return previous.todos.length != current.todos.length ||
          previous.isLoading != current.isLoading ||
          previous.error != current.error ||
          !const ListEquality().equals(previous.todos, current.todos);
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Enter todo content',
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _textController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  todoStore.addTodo(_textController.text);
                  Navigator.pop(context);
                  _textController.clear();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: StateBuilder<TodoState>(
        store: todoStore,
        shouldRebuild: _shouldRebuild,
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return TodoItem(
                key: ValueKey(todo.id),
                todo: todo,
                onToggle: () => todoStore.toggleTodo(todo.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
    onPressed: () => _showAddDialog(context),
    child: const Icon(Icons.add),
  ),

    );
  }
}