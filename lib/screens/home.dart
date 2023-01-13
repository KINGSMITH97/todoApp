import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/model/todo.dart';

import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});
  final todoList = Todo.todoList();

  final todoController = TextEditingController();

  List<Todo> fitlteredTodo = [];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    widget.fitlteredTodo = widget.todoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBgColor,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                seacrhBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 40,
                          bottom: 20,
                        ),
                        child: const Text(
                          "All ToDo's",
                          style: TextStyle(
                            color: tdSecondary,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      for (Todo todo in widget.fitlteredTodo.reversed)
                        TodoItem(
                          todo: todo,
                          onTap: () => checkIfTaskComplete(todo),
                          deleteTask: () => deleteTask(todo.id),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20, left: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [BoxShadow(
                        offset: Offset(0,0),
                        color: Colors.white,
                        blurRadius: 4,
                        spreadRadius: 0.5,
                      )],
                    ),
                    child: TextField(
                      controller: widget.todoController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add a todo",
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      addTodo();
                      } ,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdSecondary,
                      elevation: 5,
                    ),
                    child: const Text(
                      "+",
                      style: TextStyle(fontSize: 60),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void searchFilter(String keywordEntered){
    List<Todo> result = [];
    if(keywordEntered.isEmpty){
      result  = widget.fitlteredTodo;
    }else{
      result = widget.todoList.where((task) => task.todoText.toLowerCase().contains(keywordEntered.toLowerCase())).toList();
    } 
    setState(() {
      widget.fitlteredTodo = result;
    });
  }

  void checkIfTaskComplete(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void deleteTask(String id) {
    setState(() {
      widget.todoList.removeWhere((todo) => todo.id == id);
    });
  }

  void addTodo() {
    setState(() {
      widget.todoList.add(
      Todo(
        todoText: widget.todoController.text,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    );
   
    });
    widget.todoController.clear();
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: tdBgColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(
            Icons.menu,
            size: 30,
          ),
          CircleAvatar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget seacrhBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        onChanged: (value) {
          searchFilter(value);
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: tdSecondary,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          hintText: "Search..",
          hintStyle: TextStyle(color: tdSecondary),
        ),
      ),
    );
  }
}
