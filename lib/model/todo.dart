class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Free Time', isDone: true ),
      ToDo(id: '02', todoText: 'Morning snack', isDone: true ),
      ToDo(id: '03', todoText: 'Doing Work', ),
      ToDo(id: '04', todoText: 'launch', ),
      ToDo(id: '05', todoText: 'get ready for office', ),
      ToDo(id: '06', todoText: 'Study', ),
      ToDo(id: '07', todoText: 'exercise', ),
      ToDo(id: '08', todoText: 'Buying the books', ),
    ];
  }
}