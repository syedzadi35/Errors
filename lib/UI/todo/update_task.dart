import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syeda_firebase/UI/auth/customwidget/custom_button.dart';

import 'package:syeda_firebase/utils/color.dart';
import 'package:syeda_firebase/utils/toast.dart';
// Updated import for AppColors

class UpdateTaskScreen extends StatefulWidget {
  const UpdateTaskScreen({super.key, this.title, this.description, this.id});

  final String? title;
  final String? description;
  final String? id;

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final database = FirebaseDatabase.instance.ref('todo');
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isDataAdded = false;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title ?? '';
    descriptionController.text = widget.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.maincolor,
      appBar: AppBar(
        title: Text(
          'Update Screen',
          style: TextStyle(color: AppColors.blackcolor),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Update Task',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondcolor,
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: titleController,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: const TextStyle(fontSize: 16),
                  fillColor: AppColors.secondcolor,
                  filled: true,
                  enabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: descriptionController,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: const TextStyle(fontSize: 16),
                  fillColor: AppColors.secondcolor,
                  filled: true,
                  enabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CUstomButton(
                isloading: isDataAdded,
                text: 'Update Task',
                btncolor: AppColors.secondcolor.withOpacity(.4),
                ontap: () {
                  if (titleController.text.isEmpty) {
                    fluttertoas().showpopup(AppColors.redcolor,
                        'Please enter a title for the task');
                  } else if (descriptionController.text.isEmpty) {
                    fluttertoas().showpopup(AppColors.redcolor,
                        'Please enter a description for the task');
                  } else {
                    setState(() {
                      isDataAdded = true;
                    });
                    database.child(widget.id!).update({
                      'title': titleController.text.trim(),
                      'description': descriptionController.text.trim(),
                    }).then((_) {
                      fluttertoas().showpopup(
                          AppColors.greencolor, 'Task updated successfully');
                      setState(() {
                        isDataAdded = false;
                      });
                      Navigator.pop(context);
                    }).catchError((error) {
                      setState(() {
                        isDataAdded = false;
                      });
                      fluttertoas()
                          .showpopup(AppColors.redcolor, 'Error: $error');
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
