import 'package:redux_todo_flutter/actions/todos_actions.dart';
import 'package:redux_todo_flutter/states/todos_state.dart';

TodosState todosReducer(TodosState state, dynamic action) {
  if (action is TodosSetAction) {
    return state.copyWith(todos: action.todos);
  } else {
    return state;
  }
}
