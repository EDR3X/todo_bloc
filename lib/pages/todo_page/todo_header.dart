import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/active_todo_counter/active_todo_counter_cubit.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text(
          'Todo',
          style: TextStyle(fontSize: 40),
        ),
        BlocBuilder<ActiveTodoCounterCubit, ActiveTodoCountState>(
          builder: (context, state) {
            return Text(
              '${state.activeTodoCount} items left',
              style: const TextStyle(fontSize: 20.0, color: Colors.redAccent),
            );
          },
        ),
        // Text(
        //     "${context.watch<ActiveTodoCounterCubit>().state.activeTodoCount} items left")
      ],
    );
  }
}
