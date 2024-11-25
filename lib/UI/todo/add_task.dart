import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syeda_firebase/UI/auth/customwidget/custom_button.dart'; // Import the CustomButton
import 'package:syeda_firebase/utils/color.dart';
import 'package:syeda_firebase/utils/toast.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final DatabaseReference database = FirebaseDatabase.instance.ref('todo');

  bool isDataAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      backgroundColor: AppColors.maincolor.withOpacity(.9),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add Task',
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
                // Updated to use CUstomButton
                isloading: isDataAdded,
                text: 'Add Task',
                btncolor: AppColors.secondcolor.withOpacity(.4),
                ontap: () {
                  if (titleController.text.isEmpty) {
                    fluttertoas().showpopup(
                        AppColors.redcolor, 'Please enter title of task');
                  } else if (descriptionController.text.isEmpty) {
                    fluttertoas().showpopup(
                        AppColors.redcolor, 'Please enter description of task');
                  } else {
                    isDataAdded = true;
                    setState(() {});

                    String id =
                        DateTime.now().microsecondsSinceEpoch.toString();

                    database.child(id).set({
                      'title': titleController.text.trim(),
                      'description': descriptionController.text.trim(),
                      'id': id,
                      'uid': FirebaseAuth.instance.currentUser!.uid,
                    }).then((v) {
                      fluttertoas().showpopup(
                          AppColors.greencolor, 'Task Added Successfully');
                      titleController.clear();
                      descriptionController.clear();
                      isDataAdded = false;
                      setState(() {});
                      Navigator.pop(context);
                    }).onError((error, v) {
                      isDataAdded = false;
                      setState(() {});
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
