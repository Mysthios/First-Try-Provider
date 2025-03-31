import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week5/models/task_model.dart';
import 'package:week5/provider/task_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,

        title: Text("Task App", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: Consumer<TaskProvider>(builder: (context, TaskProvider, child) {
        return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: () {
                    TaskProvider.createTask(titleController.text);
                    titleController.clear();
                  }, child: Text("Save Task")),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ListView.builder(
              itemCount: TaskProvider.allTask.length,
              itemBuilder: (context, index) {
                Task task = TaskProvider.allTask[index];
                
                return ListTile(
                  onLongPress: () {
                    TaskProvider.deleteTask(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("The Task. ${task.title} has been deleted"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  title: Text(
                    task.title,
                    style: TextStyle(decoration: task.isCompleted ? 
                    TextDecoration.lineThrough : TextDecoration.none),
                  ),

                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      TaskProvider.toggleTaskCompletion(index);
                      print(value);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      );
      })
      
    );
  }
}
