import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syeda_firebase/UI/auth/customwidget/custom_button.dart';

import 'package:syeda_firebase/UI/auth/signup/signupscreen.dart';

import 'package:syeda_firebase/UI/todo/homescreen.dart';
import 'package:syeda_firebase/utils/color.dart';
import 'package:syeda_firebase/utils/toast.dart';
// Import AppColors

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isloading = false;

  loginFunction() {
    isloading = true;
    setState(() {});
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((v) {
      fluttertoas().showpopup(AppColors.greencolor, 'Login successful');
      isloading = false;
      setState(() {});
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
                'Login Screen',
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
                text: 'Login',
                btncolor: AppColors.secondcolor, // Updated button color
                ontap: loginFunction,
              ),
              SizedBox(
                height: 10.h,
              ),
              CUstomButton(
                text: 'Signup',
                btncolor: AppColors.secondcolor
                    .withOpacity(.5), // Updated button color
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
