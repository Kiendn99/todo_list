import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/extensions/datetime_extension.dart';

import '../controller/task_controller.dart';
import '../models/task_model.dart';

class TaskDetailScreen extends StatefulWidget {
  TaskModel task;
  TaskDetailScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TaskController>().initTextFieldController(title: widget.task.title, description: widget.task.description, dateTime: widget.task.time);
  }

  @override
  Widget build(BuildContext context) {
    final addTaskController = Provider.of<TaskController>(context, listen: false);
    return Consumer<TaskController>(builder: (context, data, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text(data.isEdit ? "Edit Task" : "Task Detail"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 35.h),
              child: AbsorbPointer(
                absorbing: !data.isEdit,
                child: Form(
                  key: addTaskController.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: addTaskController.titleController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => addTaskController.validateTitle(value!),
                        decoration: InputDecoration(
                            label: Text("Title"),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                            labelStyle: TextStyle(fontSize: 20.sp),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r))),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50.h),
                        child: TextFormField(
                          maxLines: null,
                          minLines: 5,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: addTaskController.descriptionController,
                          validator: (value) => addTaskController.validateDescription(value!),
                          decoration: InputDecoration(
                              label: Text("Description"),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                              labelStyle: TextStyle(fontSize: 20.sp),
                              alignLabelWithHint: true,
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r))),
                        ),
                      ),
                      Consumer<TaskController>(builder: (context, data, child) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 30.h),
                              child: ElevatedButton.icon(
                                  onPressed: () => addTaskController.pickDateTime(),
                                  icon: Icon(
                                    Icons.calendar_month_rounded,
                                  ),
                                  label: Text(data.time == null ? "Choose a time" : data.time!.formatDateTimeString)),
                            ),
                            Visibility(
                              visible: data.time == null,
                              child: Text(
                                "Pick Date Time",
                                style: TextStyle(color: Colors.red, fontSize: 15.sp),
                              ),
                            )
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => addTaskController.updateTask(widget.task.id!),
            child: Icon(
              data.isEdit ? Icons.done : Icons.edit,
            ),
          ));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.context!.read<TaskController>().disposeTextFieldController();
  }
}
