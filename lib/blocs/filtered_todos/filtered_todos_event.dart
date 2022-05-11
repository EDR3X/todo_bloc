part of 'filtered_todos_bloc.dart';

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();

  @override
  List<Object> get props => [];
}

class CalculatefilteredTodosEvent extends FilteredTodosEvent {
  final List<Todo> filteredTodos;
  const CalculatefilteredTodosEvent({
    required this.filteredTodos,
  });

  @override
  String toString() =>
      'CalculatefilteredTodosEvent(filteredTodos: $filteredTodos)';

  @override
  List<Object> get props => [filteredTodos];
}
