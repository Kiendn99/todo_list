import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/screen/task_detail_screen.dart';
import 'package:todo_list/core/extensions/datetime_extension.dart';

import '../controller/task_controller.dart';

class TaskUndoneLayout extends StatelessWidget {
  const TaskUndoneLayout({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context, listen: false);

    return Consumer<TaskController>(builder: (context, data, child) {
      return data.taskList.isEmpty
          ? Center(
              child: Text(
              "There are currently no tasks, just add them now",
              style: TextStyle(fontSize: 18.sp),
              textAlign: TextAlign.center,
            ))
          : ListView.builder(
              itemCount: data.taskList.length,
              shrinkWrap: true,
              itemBuilder: (_, index) => InkWell(
                    onTap: () => Get.to(() => TaskDetailScreen(
                          task: data.taskList[index],
                        )),
                    onLongPress: () => data.addTaskDoneTempo(data.taskList[index]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: data.isTaskChecked(data.taskList[index]),
                                  onChanged: (value) => data.addTaskDoneTempo(data.taskList[index]),
                                ),
                                Text(
                                  data.taskList[index].title!,
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ],
                            ),
                            IconButton(onPressed: () => data.deleteATask(data.taskList[index].id!), icon: Icon(Icons.delete_forever_outlined))
                          ],
                        ),
                        Divider(
                          thickness: 1.5,
                          height: 0,
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10.h, left: 50.w, bottom: 15.h),
                            child: Text(
                              data.taskList[index].time!.formatDateTimeString,
                            ))
                      ],
                    ),
                  ));
    });
  }
}