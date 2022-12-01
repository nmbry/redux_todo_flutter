import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_todo_flutter/actions/todos_actions.dart';
import 'package:redux_todo_flutter/middlewares/todos_middlewares.dart';
import 'package:redux_todo_flutter/reducers/app_reducer.dart';
import 'package:redux_todo_flutter/states/app_state.dart';
import 'package:redux_todo_flutter/views/todos_screen/todos_screen.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: const AppState(),
    distinct: true, // Stateが同じ値の場合は再描画を行わない設定
    middleware: [
      ...todosMiddlewares,
    ],
  );

  runApp(MyApp(store: store));

  // 保存された内容を読み込む
  store.dispatch(const TodosLoadAction());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.store,
  });

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Redux Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosScreen(),
      ),
    );
  }
}
