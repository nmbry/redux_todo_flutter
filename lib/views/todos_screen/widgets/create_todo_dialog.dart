import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../states/app_state.dart';
import '../../../viewModels/todos_view_model.dart';

///
/// Reduxを利用するとStatelessのみで実行できるはずなのに、あえてStatefulを利用した
/// 理由は以下の２点
/// - TextFieldのインプットに対してボタンの活性状態を再現したかった
/// - _textEditingControllerのdispose()をライフサイクルに合わせて実現する必要があった
///
class CreateTodoDialog extends StatefulWidget {
  const CreateTodoDialog({
    Key? key,
    required this.uuid,
  }) : super(key: key);

  final String uuid;

  @override
  State<CreateTodoDialog> createState() => _CreateTodoDialogState();
}

class _CreateTodoDialogState extends State<CreateTodoDialog> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TodosViewModel>(
      converter: (store) => TodosViewModel.fromStore(store),
      builder: (context, viewModel) {
        return AlertDialog(
          title: const Text('新規登録'),
          content: TextField(
            autofocus: true,
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: '入力してください'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: _textEditingController.value.text.isNotEmpty
                  ? () {
                      viewModel.addTodo(widget.uuid, _textEditingController.value.text);
                      Navigator.of(context).pop();
                    }
                  : null,
              child: const Text('登録する'),
            ),
          ],
        );
      },
    );
  }
}
