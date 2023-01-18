import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/model/todo.dart';

class TodoItem extends StatefulWidget {
  const TodoItem(
      {super.key,
      required this.todo,
      required this.onTap,
      required this.deleteTask});
  final Todo todo;
  final Function()? onTap;
  final Function()? deleteTask;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: ListTile(
        onTap: widget.onTap,
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: widget.todo.isDone
            ? const Icon(
                Icons.check_box,
                color: tdSecondary,
              )
            : const Icon(Icons.check_box_outline_blank),
        title: Text(
          widget.todo.todoText,
          style: TextStyle(
            decoration: widget.todo.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: tdRedColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: IconButton(
            onPressed: widget.deleteTask,
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
