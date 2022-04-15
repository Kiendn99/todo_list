import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/controller/task_controller.dart';
import 'package:todo_list/app/screen/task_undone_layout.dart';
import 'package:todo_list/app/screen/task_done_layout.dart';
import 'package:todo_list/core/extensions/datetime_extension.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context, listen: false);

    ScreenUtil.init(context, minTextAdapt: true, designSize: const Size(393, 826));
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today is " + DateTime.now().formatDayString,
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  IconButton(
                    onPressed: () => taskController.deleteAllTask(),
                    icon: Icon(Icons.delete_forever),
                    iconSize: 25.h,
                  )
                ],
              ),
              Expanded(
                child: PageView(
                  controller: taskController.pageController,
                  onPageChanged: (index) => taskController.selectedIndex = index,
                  children: [
                    TaskUndoneLayout(),
                    TaskDoneLayout(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Selector<TaskController, bool>(
            selector: (context, taskController) => taskController.doDoneTask,
            builder: (context, isDoneTask, child) {
              return FloatingActionButton(
                onPressed: () => taskController.addTaskDoneList(),
                child: Icon(isDoneTask ? Icons.done : Icons.add),
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Selector<TaskController, int>(
            selector: (context, taskController) => taskController.selectedIndex,
            builder: (context, selectedIndex, child) {
              return BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.work),
                    label: 'Undone task',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.task),
                    label: 'Tasks done',
                  ),
                ],
                currentIndex: selectedIndex,
                type: BottomNavigationBarType.shifting,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.black,
                onTap: (index) {
                  {
                    taskController.selectedIndex = index;
                    taskController.pageController.animateToPage(
                      index,
                      duration: const Duration(
                        milliseconds: 200,
                      ),
                      curve: Curves.easeIn,
                    );
                  }
                },
              );
            }),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text("My Task"),
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 50.sp, color: Colors.black),
      toolbarHeight: 100.h,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
