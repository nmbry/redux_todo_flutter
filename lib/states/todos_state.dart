import 'package:flutter/material.dart';

import '../models/todo_model.dart';

@immutable
class TodosState {
  const TodosState({
    this.todos = const [],
  });

  final List<TodoModel> todos;

  TodosState copyWith({
    List<TodoModel>? todos,
  }) {
    return TodosState(
      todos: todos ?? this.todos,
    );
  }
}
