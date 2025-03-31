import 'package:flutter/material.dart';
import 'package:week5/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _allTask = [];
  List<Task> get allTask => _allTask;

  createTask(String title) {
    _allTask.add(Task(title: title));
    notifyListeners();
  }

  toggleTaskCompletion(int index) {
    _allTask[index].isCompleted = !_allTask[index].isCompleted;
    notifyListeners();
  }

  deleteTask(int index){
    _allTask.removeAt(index);
    notifyListeners();
  }

}
