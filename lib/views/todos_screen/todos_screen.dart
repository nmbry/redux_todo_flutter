import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_todo_flutter/viewModels/todos_view_model.dart';
import 'package:uuid/uuid.dart';

import '../../states/app_state.dart';
import 'widgets/create_todo_dialog.dart';

const uuid = Uuid();

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key}) : super(key: key);

  /// SnackBarを表示する
  void _showSnackBar(BuildContext context, String label) {
    final snackBar = SnackBar(
      content: Text('「$label」の項目を削除しました!'),
      action: SnackBarAction(
        label: '完了',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// AlertDialogを表示する
  void _showDialog(BuildContext context, String uuid) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CreateTodoDialog(uuid: uuid);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TodosViewModel>(
      converter: (store) => TodosViewModel.fromStore(store),
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text('Todoアプリ'),
            ),
          ),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.grey[200],
              child: ListView.builder(
                itemCount: viewModel.todos.length,
                itemBuilder: (context, index) {
                  final todo = viewModel.todos[index];

                  return Dismissible(
                    key: ObjectKey(todo),
                    onDismissed: (direction) {
                      viewModel.deleteTodo(todo.uuid);
                      _showSnackBar(context, todo.label);
                    },
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    child: Card(
                      color: todo.isCompleted ? Colors.greenAccent : Colors.white,
                      child: ListTile(
                        title: Text(
                          todo.label,
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        trailing: todo.isCompleted
                            ? const Icon(Icons.check_box_outlined)
                            : const Icon(Icons.check_box_outline_blank_outlined),
                        onTap: () => viewModel.toggleTodo(todo.uuid),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: '新規登録',
            onPressed: () => _showDialog(context, uuid.v1()),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
