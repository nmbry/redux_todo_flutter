import 'package:redux_todo_flutter/reducers/todos_reducer.dart';
import 'package:redux_todo_flutter/states/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    todosState: todosReducer(state.todosState, action),
  );
}
