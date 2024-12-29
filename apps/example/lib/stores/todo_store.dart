class TodoStore extends StateStore<TodoState> {
  TodoStore() : super(TodoState());

  Future<void> loadTodos() async {
    updatePartial((state) => state.copyWith(isLoading: true));

    await updateAsync(() async {
      try {
        await Future.delayed(Duration(seconds: 1)); // FAKE API CALL
        final todos = [
          Todo(id: '1', title: 'Test State Manager'),
          Todo(id: '2', title: 'Write Documentation'),
        ];
        return TodoState(todos: todos, isLoading: false);
      } catch (e) {
        return TodoState(error: e.toString(), isLoading: false);
      }
    });
  }

  void addTodo(String title) {
    updatePartial((state) {
      final newTodo = Todo(
        id: DateTime.now().toString(),
        title: title,
      );
      return state.copyWith(
        todos: [...state.todos, newTodo],
      );
    });
  }
}