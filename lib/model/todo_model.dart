class Todo {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final String timeStamp;

  Todo(
    { required this.id, 
      required this.title, 
      required this.description, 
      required this.completed, 
      required this.timeStamp});
}
