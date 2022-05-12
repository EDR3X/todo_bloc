import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/blocs.dart';
import 'package:todo_bloc/pages/todo_page/todo_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterBloc>(
          create: (context) => TodoFilterBloc(),
        ),
        BlocProvider<TodoSearchBloc>(
          create: (context) => TodoSearchBloc(),
        ),
        BlocProvider<TodoListBloc>(
          create: (context) => TodoListBloc(),
        ),
        BlocProvider<ActiveTodoCountBloc>(
          create: (context) => ActiveTodoCountBloc(
            initialActiveTodoCount:
                context.read<TodoListBloc>().state.todos.length,
            todoListBloc: BlocProvider.of<TodoListBloc>(context),
          ),
        ),
        BlocProvider<FilteredTodosBloc>(
          create: (context) => FilteredTodosBloc(
            initialTodos: context.read<TodoListBloc>().state.todos,
            todoFilterBloc: BlocProvider.of<TodoFilterBloc>(context),
            todoSearchBloc: BlocProvider.of<TodoSearchBloc>(context),
            todoListBloc: BlocProvider.of<TodoListBloc>(context),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Todo App",
        theme: ThemeData(primarySwatch: Colors.green),
        home: const TodoPage(),
      ),
    );
  }
}
