import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/blocs.dart';
import 'package:todo_bloc/models/todo_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosBloc>().state.filteredTodos;
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Colors.grey,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: ValueKey(todos[index].id),
          background: showBackground(0),
          secondaryBackground: showBackground(1),
          onDismissed: (_) {
            context
                .read<TodoListBloc>()
                .add(RemoveTodoEvent(todo: todos[index]));
          },
          confirmDismiss: (_) => showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text("Are you suree?"),
              content: const Text("Do you really want to delete?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Yes"),
                ),
              ],
            ),
          ),
          child: TodoItem(todo: todos[index]),
        );
      },
    );
  }

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => showDialog(
        context: context,
        builder: (context) {
          bool _error = false;
          textController.text = widget.todo.desc;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: const Text('Edit Todo'),
                content: TextField(
                  controller: textController,
                  autofocus: true,
                  decoration: InputDecoration(
                    errorText: _error ? 'Value cannot be empty' : null,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => setState(
                      () {
                        _error = textController.text.isEmpty ? true : false;
                        if (!_error) {
                          context.read<TodoListBloc>().add(EditTodoEvent(
                              id: widget.todo.id,
                              todoDesc: textController.text));
                          Navigator.pop(context);
                        }
                      },
                    ),
                    child: const Text("Edit"),
                  ),
                ],
              );
            },
          );
        },
      ),
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          context.read<TodoListBloc>().add(ToggleTodoEvent(id: widget.todo.id));
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}
