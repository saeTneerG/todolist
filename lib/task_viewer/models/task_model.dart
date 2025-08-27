class Task {
  String title;
  String description;
  bool complete;
  String taskId;

   Task ( this.taskId, this.title, this.description, this.complete);

   Map<String, dynamic> toMap() {
     return {
       'title': title,
       'description': description,
       'complete': complete,
       'task_id': taskId,
     };
   }

   factory Task.fromMap(Map<String, dynamic> map) {
     return Task(
       map['title'],
       map['description'],
       map['complete'],
       map['task_id'],
     );
   }

   @override
   String toString() {
     return 'Task( taskId: $taskId, title: $title, description: $description, complete: $complete)';
   }
}