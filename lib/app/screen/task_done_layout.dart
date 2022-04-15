import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/extensions/datetime_extension.dart';

import '../controller/task_controller.dart';

class TaskDoneLayout extends StatelessWidget {
  const TaskDoneLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context, listen: false);

    return Consumer<TaskController>(builder: (context, data, child) {
      return data.taskDoneList.isEmpty
          ? Center(
              child: Text(
              "There are currently no tasks, just add them now",
              style: TextStyle(fontSize: 18.sp),
              textAlign: TextAlign.center,
            ))
          : ListView.builder(
              itemCount: data.taskDoneList.length,
              shrinkWrap: true,
              itemBuilder: (_, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: true,
                                shape: const CircleBorder(),
                                onChanged: (value) {},
                              ),
                              Text(
                                data.taskDoneList[index].title!,
                                style: TextStyle(fontSize: 18.sp),
                              ),
                            ],
                          ),
                          IconButton(onPressed: () => data.deleteATask(data.taskDoneList[index].id!), icon: Icon(Icons.delete_forever_outlined))
                        ],
                      ),
                      Divider(
                        thickness: 1.5,
                        height: 0,
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10.h, left: 50.w, bottom: 15.h),
                          child: Text(
                            data.taskDoneList[index].time!.formatDateTimeString,
                          ))
                    ],
                  ));
    });
  }
}
