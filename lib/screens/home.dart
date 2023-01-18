import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/widgets/custom_app_bar.dart';
import 'package:todo_app/widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TodoProvider todoProvider;

  late TextEditingController todoTextController;

  @override
  void initState() {
    todoProvider = context.read<TodoProvider>();
    todoTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    todoTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBgColor,
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          seacrhBox(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Consumer<TodoProvider>(
                        builder: (context, todoProvider, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 40,
                                  bottom: 20,
                                ),
                                child: Text(
                                  "All ToDo's",
                                  style: TextStyle(
                                    color: tdSecondary,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              ...todoProvider.filterdTodos.map(
                                (todo) => TodoItem(
                                  todo: todo,
                                  onTap: () {
                                    todoProvider.checkIfTaskComplete(todo);
                                  },
                                  deleteTask: () {
                                    todoProvider.deleteTodo(currentTodo: todo);
                                  },
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 75,
            color: tdBgColor,
            width: double.maxFinite,
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
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0),
                          color: Colors.white,
                          blurRadius: 4,
                          spreadRadius: 0.5,
                        )
                      ],
                    ),
                    child: TextField(
                      controller: todoTextController,
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
                  child: TextButton(
                    onPressed: () {
                      if (todoTextController.text.isEmpty ||
                          todoTextController.text == "") return;
                      Todo todo = Todo(
                        todoText: todoTextController.text,
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                      );
                      todoProvider.addTodo(todo: todo);

                      todoTextController.clear();
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: tdSecondary,
                      fixedSize: const Size(65, 65),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
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

  Widget seacrhBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        onChanged: (value) {
          todoProvider.searchFilter(value);
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
