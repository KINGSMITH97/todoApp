
class Todo {
  final String todoText;
   bool isDone;
  final String id;

  Todo({required this.todoText, this.isDone = false, required this.id});

  static List<Todo> todoList(){
    return [
      Todo(todoText: "First Music", isDone: false, id: "01"),
      Todo(todoText: "Make tutorial", isDone: true, id: "02"),   
    ];
  }
}