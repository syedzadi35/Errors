import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:syeda_firebase/utils/color.dart';
// Import the AppColors class

class CUstomButton extends StatelessWidget {
  const CUstomButton({
    super.key,
    required this.text,
    required this.btncolor,
    this.isloading = false,
    required this.ontap,
  });

  final String text;
  final Color btncolor;
  final VoidCallback ontap;
  final bool isloading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 40.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: btncolor, borderRadius: BorderRadius.circular(10.r)),
        child: isloading
            ? Center(
                child: SizedBox(
                    height: 35.h,
                    width: 40.w,
                    child: CircularProgressIndicator(
                      color: AppColors.maincolor, // Updated to use AppColors
                    )))
            : Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: AppColors.blackcolor, // Updated to use AppColors
                    fontSize: 20.sp,
                  ),
                ),
              ),
      ),
    );
  }
}
