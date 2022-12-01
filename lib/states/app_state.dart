import 'package:flutter/material.dart';
import 'package:redux_todo_flutter/states/global_state.dart';
import 'package:redux_todo_flutter/states/todos_state.dart';

@immutable
class AppState {
  const AppState({
    this.globalState = const GlobalState(),
    this.todosState = const TodosState(),
  });

  final GlobalState globalState;
  final TodosState todosState;
}
