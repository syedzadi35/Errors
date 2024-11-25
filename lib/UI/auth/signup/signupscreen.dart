import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syeda_firebase/UI/auth/Login/loginscreeen.dart';
import 'package:syeda_firebase/UI/auth/customwidget/custom_button.dart';
import 'package:syeda_firebase/UI/todo/homescreen.dart';
import 'package:syeda_firebase/utils/color.dart';
import 'package:syeda_firebase/utils/toast.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final db = FirebaseDatabase.instance.ref('appuser');
  final ref = FirebaseFirestore.instance.collection('appuser');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isloading = false;

  signupFunction() {
    isloading = true;
    setState(() {});

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((v) {
      ref.doc(v.user!.uid).set({
        "name": "kaleem",
        'email': emailController.text.trim().toString(),
        'uid': v.user!.uid
      });

      fluttertoas().showpopup(AppColors.greencolor, 'Signup successful');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      isloading = false;
      setState(() {});
    }).onError((error, Stack) {
      fluttertoas().showpopup(AppColors.redcolor, error.toString());
      isloading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.maincolor.withOpacity(.9),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Signup Screen',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.secondcolor, // Updated color
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                controller: emailController,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: const TextStyle(fontSize: 16),
                  fillColor: AppColors.secondcolor, // Updated color
                  filled: true,
                  enabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Password',
                  enabledBorder: InputBorder.none,
                  hintStyle: const TextStyle(fontSize: 16),
                  fillColor: AppColors.secondcolor, // Updated color
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CUstomButton(
                isloading: isloading,
                text: 'Signup',
                btncolor: AppColors.secondcolor,
                ontap: signupFunction,
              ),
              SizedBox(
                height: 10.h,
              ),
              CUstomButton(
                text: 'Login',
                btncolor: AppColors.secondcolor.withOpacity(0.5),
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
