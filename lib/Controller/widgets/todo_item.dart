import 'package:flutter/material.dart';
import '../../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          // print('Clicked on Todo Item.');
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: Icon(
          color: Colors.lightBlueAccent.shade100,
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            iconSize: 25,
            icon: Icon(Icons.delete),color: Colors.red,
            onPressed: () {
              // print('Clicked on delete icon');
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
