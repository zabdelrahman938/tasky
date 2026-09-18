
enum TaskItemActionEnum{
  MarkAsDone(name: "Done / unDone"),
  Edit(name: "Edit"),
  Delete(name: "Delete");
  final String name;
  const TaskItemActionEnum({required this.name});

}