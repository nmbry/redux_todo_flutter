import 'package:redux_todo_flutter/models/todo_model.dart';

/// TODOを新規登録する
class TodoAddAction {
  const TodoAddAction(this.uuid, this.label);

  final String uuid;
  final String label;
}

/// TODOを削除する
class TodoDeleteAction {
  const TodoDeleteAction(this.uuid);

  final String uuid;
}

/// TODOの完了状態をトグルする
class TodoToggleAction {
  const TodoToggleAction(this.uuid);

  final String uuid;
}

/// TODOリストをセットする
class TodosSetAction {
  const TodosSetAction(this.todos);

  final List<TodoModel> todos;
}

/// TODOリストをSharedPreferencesで保存する
class TodosSaveAction {
  const TodosSaveAction();
}

/// TODOリストをSharedPreferencesから読み取る
class TodosLoadAction {
  const TodosLoadAction();
}
