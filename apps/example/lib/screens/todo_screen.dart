import 'package:example/models/todo_state.dart';
import 'package:example/stores/todo_store.dart';
import 'package:flutter/material.dart';
import 'package:state_mgr/state_mgr.dart';

class TodoScreen extends StatelessWidget {
  final todoStore = TodoStore();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StateBuilder<TodoState>(
      store: todoStore,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Todos')),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];
                    return ListTile(
                      title: Text(todo.title),
                      leading: Checkbox(
                        value: todo.completed,
                        onChanged: (_) => todoStore.toggleTodo(todo.id),
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => todoStore.addTodo('New Todo'),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}