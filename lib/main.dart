import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/controller/task_controller.dart';

import 'app/screen/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Todo List',
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.rightToLeft,
          home: MyHomePage(),
          theme: ThemeData(
            textTheme: GoogleFonts.dancingScriptTextTheme()
          ),
        );
      },
      providers: [
        ChangeNotifierProvider(create: (_) => TaskController()),
      ],
    );
  }
}
