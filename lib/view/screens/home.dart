import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controller/constants/Theme.dart';
import '../../Controller/widgets/todo_item.dart';
import '../../model/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("TO_DO_APP"),
          actions: [
            IconButton(
                icon: Icon(themeNotifier.isDark
                    ? Icons.nightlight_round
                    : Icons.wb_sunny),
                onPressed: () {
                  themeNotifier.isDark
                      ? themeNotifier.isDark = false
                      : themeNotifier.isDark = true;
                }),
          ],
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                children: [
                  searchBox(),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 20,
                            right: 20,
                            left: 20,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _todoController,
                            decoration: const InputDecoration(
                              hintText: 'Add a new todo item',
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                          right: 20,
                        ),
                        child: FloatingActionButton(
                          backgroundColor: Colors.lightBlueAccent.shade100,
                          foregroundColor: Colors.black,
                          child: const Text(
                            '+',
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          onPressed: () {
                            _addToDoItem(_todoController.text);
                          },
                          // style: ElevatedButton.styleFrom(
                          //   minimumSize: const Size(60, 60),
                          //   elevation: 10,
                          // ),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 50,
                            bottom: 20,
                          ),
                          child: const Text(
                            'All ToDos',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        for (ToDo todoo in _foundToDo.reversed)
                          ToDoItem(
                            todo: todoo,
                            onToDoChanged: _handleToDoChange,
                            onDeleteItem: _deleteToDoItem,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      );
    });
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
          item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(),
        ),
      ),
    );
  }
}
