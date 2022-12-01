import 'package:redux/redux.dart';
import 'package:redux_todo_flutter/actions/todos_actions.dart';
import 'package:redux_todo_flutter/models/todo_model.dart';
import 'package:redux_todo_flutter/states/app_state.dart';

List<Middleware<AppState>> todosMiddlewares = [
  /// TodoAddAction
  TypedMiddleware<AppState, TodoAddAction>((store, action, next) {
    final todosState = store.state.todosState;
    final newTodos = [...todosState.todos, TodoModel(uuid: action.uuid, label: action.label)];

    next(TodosSetAction(newTodos));
  }),

  /// TodoDeleteAction
  TypedMiddleware<AppState, TodoDeleteAction>((store, action, next) {
    final todosState = store.state.todosState;
    final newTodos = todosState.todos.where((todo) => todo.uuid != action.uuid).toList();

    next(TodosSetAction(newTodos));
  }),

  /// TodoToggleAction
  TypedMiddleware<AppState, TodoToggleAction>((store, action, next) {
    final todosState = store.state.todosState;
    final newTodos = todosState.todos
        .map((todo) => (todo.uuid == action.uuid) ? todo.copyWith(isCompleted: !todo.isCompleted) : todo)
        .toList();

    next(TodosSetAction(newTodos));
  }),
];
