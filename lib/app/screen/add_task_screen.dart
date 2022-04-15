import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/extensions/datetime_extension.dart';

import '../controller/task_controller.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TaskController>().initTextFieldController();
  }

  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("Add a new task"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 35.h),
            child: Form(
              key: taskController.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: taskController.titleController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => taskController.validateTitle(value!),
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

                      controller: taskController.descriptionController,
                      validator: (value) => taskController.validateDescription(value!),
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
                  Consumer<TaskController>(
                    builder: (context, data, child) {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30.h),
                            child: ElevatedButton.icon(
                                onPressed: () => taskController.pickDateTime(),
                                icon: Icon(
                                  Icons.calendar_month_rounded,
                                ),
                                label: Text(data.time==null ? "Choose a time": data.time!.formatDateTimeString  )),
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
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => taskController.addANewTask(),
          child: Icon(Icons.addchart_sharp),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.context!.read<TaskController>().disposeTextFieldController();
  }
}
