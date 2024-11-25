import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syeda_firebase/UI/auth/customwidget/custom_button.dart';

import 'package:syeda_firebase/utils/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final database = FirebaseDatabase.instance.ref('todo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.maincolor,
      appBar: AppBar(
        backgroundColor: AppColors.maincolor,
        title: Text(
          'Home Screen',
          style: TextStyle(color: AppColors.secondcolor),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Home Screen',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondcolor,
                ),
              ),
              SizedBox(height: 20.h),
              CUstomButton(
                text: 'Add New Task',
                btncolor: AppColors.greencolor,
                ontap: () {
                  // Navigate to Add Task Screen
                  Navigator.pushNamed(context, '/addTask');
                },
              ),
              SizedBox(height: 20.h),
              CUstomButton(
                text: 'View Tasks',
                btncolor: AppColors.secondcolor.withOpacity(0.7),
                ontap: () {
                  // Navigate to View Task Screen
                  Navigator.pushNamed(context, '/viewTasks');
                },
              ),
              SizedBox(height: 20.h),
              CUstomButton(
                text: 'Logout',
                btncolor: AppColors.redcolor,
                ontap: () {
                  // Handle Logout functionality
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
