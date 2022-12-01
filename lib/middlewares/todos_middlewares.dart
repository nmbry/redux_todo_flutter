import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:redux_todo_flutter/actions/todos_actions.dart';
import 'package:redux_todo_flutter/models/todo_model.dart';
import 'package:redux_todo_flutter/states/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _sharedPreferencesJsonKey = 'todosJson';

List<Middleware<AppState>> todosMiddlewares = [
  /// TodoAddAction
  TypedMiddleware<AppState, TodoAddAction>((store, action, next) async {
    final todosState = store.state.todosState;
    final newTodos = [...todosState.todos, TodoModel(uuid: action.uuid, label: action.label)];

    next(TodosSetAction(newTodos));
    next(const TodosSaveAction());
  }),

  /// TodoDeleteAction
  TypedMiddleware<AppState, TodoDeleteAction>((store, action, next) async {
    final todosState = store.state.todosState;
    final newTodos = todosState.todos.where((todo) => todo.uuid != action.uuid).toList();

    next(TodosSetAction(newTodos));
    next(const TodosSaveAction());
  }),

  /// TodoToggleAction
  TypedMiddleware<AppState, TodoToggleAction>((store, action, next) async {
    final todosState = store.state.todosState;
    final newTodos = todosState.todos
        .map((todo) => (todo.uuid == action.uuid) ? todo.copyWith(isCompleted: !todo.isCompleted) : todo)
        .toList();

    next(TodosSetAction(newTodos));
    next(const TodosSaveAction());
  }),

  /// TodosLoadAction
  TypedMiddleware<AppState, TodosLoadAction>((store, action, next) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final todosJsonText = sharedPreferences.getStringList(_sharedPreferencesJsonKey) ?? [];
    final todos = todosJsonText.map((todoText) => TodoModel.fromJson(jsonDecode(todoText))).toList();

    next(TodosSetAction(todos));
  }),

  /// TodosSaveAction
  TypedMiddleware<AppState, TodosSaveAction>((store, action, next) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final todosState = store.state.todosState;
    final todosJsonText = todosState.todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await sharedPreferences.setStringList(_sharedPreferencesJsonKey, todosJsonText);
  }),
];
