// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:todo_list/app/controller/validate_field_controller.dart';
import 'package:todo_list/app/widgets/toast.dart';
import 'package:uuid/uuid.dart';

import '../models/task_model.dart';
import '../screen/add_task_screen.dart';

class TaskController extends ChangeNotifier with ValidateFieldController {
  List<TaskModel> taskList = [];
  List<TaskModel> taskTemporary = [];
  List<TaskModel> taskDoneList = [];
  PageController pageController = PageController();
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int selectedIndex) {
    _selectedIndex = selectedIndex;
    notifyListeners();
  }

  addANewTask() {
    if (checkInvalidFormAddTask) {
      taskList.add(TaskModel(id: Uuid().v1(), title: titleController.text, description: descriptionController.text, time: time));
      Get.back();

      showToast(msg: "New task added successfully");
      notifyListeners();
    }
  }

  addTaskDoneList() {
    if (doDoneTask) {
      taskDoneList.addAll(taskTemporary);
      taskTemporary.forEach((element) => taskList.remove(element));
      taskTemporary.clear();

      notifyListeners();
    } else
      Get.to(() => AddTaskScreen());
  }

  addTaskDoneTempo(TaskModel taskDone) {
    if (taskTemporary.contains(taskDone))
      taskTemporary.remove(taskDone);
    else
      taskTemporary.add(taskDone);
    notifyListeners();
  }

  bool isTaskChecked(TaskModel task) {
    return taskTemporary.contains(task);
  }

  bool get doDoneTask => taskTemporary.isNotEmpty;

  updateTask(String id) {
    if (checkInvalidFormUpdateTask) {
      taskList[taskList.indexWhere((element) => element.id == id)] = TaskModel(id: id, title: titleController.text, description: descriptionController.text, time: time);
    showToast(msg: "Update successfully");

    }
    notifyListeners();
  }

  deleteATask(String id) {
    if (selectedIndex == 0) taskList.removeWhere((element) => element.id == id);
    taskDoneList.removeWhere((element) => element.id == id);

    notifyListeners();
  }

  deleteAllTask() {
    if (selectedIndex == 0) if (taskList.isNotEmpty)
      _showDialogDeleteTask();
    else if (taskDoneList.isNotEmpty) _showDialogDeleteTask();
  }

  _showDialogDeleteTask() {
    showAnimatedDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          titleText: 'Hey hey!!!',
          contentText: 'Clear all task to relax!!!',
          positiveText: "OK",
          negativeText: "No",
          onPositiveClick: () {
            if (selectedIndex == 0)
              taskList.clear();
            else
              taskDoneList.clear();
            Get.back();
            notifyListeners();
          },
          onNegativeClick: () => Get.back(),
        );
      },
      animationType: DialogTransitionType.slideFromTop,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 500),
    );
  }
}
