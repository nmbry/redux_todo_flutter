import 'package:redux/redux.dart';
import 'package:redux_todo_flutter/actions/todos_actions.dart';

import '../models/todo_model.dart';
import '../states/app_state.dart';

class TodosViewModel {
  const TodosViewModel({
    required Store<AppState> store,
    required List<TodoModel> todos,
  })  : _store = store,
        _todos = todos;

  final Store<AppState> _store;
  final List<TodoModel> _todos;

  static TodosViewModel fromStore(Store<AppState> store) {
    return TodosViewModel(
      store: store,
      todos: store.state.todosState.todos,
    );
  }

  /// Getter
  List<TodoModel> get todos => _todos;

  /// Function
  void addTodo(String uuid, String label) => _store.dispatch(TodoAddAction(uuid, label));

  void deleteTodo(String uuid) => _store.dispatch(TodoDeleteAction(uuid));

  void toggleTodo(String uuid) => _store.dispatch(TodoToggleAction(uuid));
}

/// 以下の実装方法でもよいが、関数の補完が効きにくく呼び出す側で引っかかる恐れがあるため上記の方法で実装を行う
// class TodosViewModel {
//   const TodosViewModel({
//     required this.todos,
//     required this.addTodo,
//     required this.deleteTodo,
//     required this.toggleTodo,
//   });
//
//   final List<TodoModel> todos;
//   final Function addTodo;
//   final Function deleteTodo;
//   final Function toggleTodo;
//
//   static TodosViewModel fromStore(Store<AppState> store) {
//     return TodosViewModel(
//       todos: store.state.todosState.todos,
//       addTodo: (String uuid, String label) => store.dispatch(TodoAddAction(uuid, label)),
//       deleteTodo: (String uuid) => store.dispatch(TodoDeleteAction(uuid)),
//       toggleTodo: (String uuid) => store.dispatch(TodoToggleAction(uuid)),
//     );
//   }
// }
