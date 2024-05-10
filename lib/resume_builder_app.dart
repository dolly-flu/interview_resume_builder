// ignore_for_file: prefer_const_constructors

import 'package:resume_builder/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/view/screen/resume/view_resume_screen.dart';

class ResumeBuilderApp extends StatelessWidget {
  const ResumeBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: IconThemeData(color: AppColor.cLabel),
      ),
      home: ViewResumeScreen(),
    );
  }
}
