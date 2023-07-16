import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/utils/app_images.dart';
class ContainerWeek extends StatelessWidget {
  const ContainerWeek({super.key, required this.text, required this.gradus});
  final String text;
  final String gradus;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Container(
        height: 56.h,
        width: 32.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            color: Colors.orangeAccent.shade100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: const Color(0xff303345),
                  fontSize: 7.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Inter"),
            ),
            Image.asset(
              AppImages.iconCloudy,
              height: 24.h,
              width: 24.h,
            ),
            Text(
              gradus,
              style: TextStyle(
                  color: const Color(0xff303345),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter"),
            )
          ],
        ),
      ),
    );
  }
}
