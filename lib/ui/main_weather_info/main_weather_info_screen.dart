import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/data/models/main/lat_lon.dart';
import 'package:weather_app/data/models/main/weather_main_model.dart';
import 'package:weather_app/data/models/universal_data.dart';
import 'package:weather_app/data/network/api_provider.dart';
import 'package:weather_app/ui/hourly_daily/hourly_daily_screen.dart';
import 'package:weather_app/ui/main_weather_info/widgets/container_week.dart';
import 'package:weather_app/utils/app_images.dart';

class MainWeatherInfoScreen extends StatefulWidget {
  const MainWeatherInfoScreen({Key? key, required this.latLong})
      : super(key: key);

  final LatLong latLong;

  @override
  State<MainWeatherInfoScreen> createState() => _MainWeatherInfoScreenState();
}

class _MainWeatherInfoScreenState extends State<MainWeatherInfoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UniversalData>(
        future: ApiProvider.getMainWeatherDataByLatLong(
          lat: widget.latLong.lat,
          long: widget.latLong.long,
        ),
        builder: (BuildContext context, AsyncSnapshot<UniversalData> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.error.isEmpty) {
              WeatherMainModel weatherMainModel =
                  snapshot.data!.data as WeatherMainModel;
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xffFEE3BC), Color(0xffF39876)])),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 11.w, vertical: 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const HourlyDailyScreen();
                              }));
                            },
                            child: SvgPicture.asset(
                              AppImages.search,
                              height: 24.h,
                              width: 24.h,
                            ),
                          ),
                          SvgPicture.asset(
                            AppImages.menu,
                            height: 24.h,
                            width: 24.h,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 48.h,
                            width: 108.w,
                            child: Text(
                              weatherMainModel.name,
                              style: TextStyle(
                                  color: const Color(0xff313341),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Inter"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15.h,
                            child: Text(
                              DateTime.fromMillisecondsSinceEpoch(
                                      weatherMainModel.dateTime * 1000)
                                  .toString(),
                              style: TextStyle(
                                  color: const Color(0xff303345),
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Inter"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            AppImages.cludy,
                            height: 80.h,
                            width: 83.w,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    (weatherMainModel.mainInMain.temp - 273)
                                        .ceil()
                                        .toString(),
                                    style: TextStyle(
                                        color: const Color(0xff9A938C),
                                        fontSize: 43.sp,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Inter"),
                                  ),
                                  Text(
                                    " °",
                                    style: TextStyle(
                                        color: const Color(0xff9A938C),
                                        fontSize: 35.sp,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Inter"),
                                  ),
                                ],
                              ),
                              Text(
                                weatherMainModel.base,
                                style: TextStyle(
                                    color: const Color(0xff9A938C),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Inter"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      height: 38.h,
                      width: 186.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: Colors.orangeAccent.shade100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Image.asset(
                              AppImages.raining,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            "RainFall",
                            style: TextStyle(
                                color: const Color(0xff303345),
                                fontSize: 7.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter"),
                          ),
                          Text(
                            "${weatherMainModel.mainInMain.seaLevel} sm",
                            style: TextStyle(
                                color: const Color(0xff303345),
                                fontSize: 7.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter"),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 38.h,
                      width: 186.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: Colors.orangeAccent.shade100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Image.asset(
                              AppImages.windy,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            "Wind",
                            style: TextStyle(
                                color: const Color(0xff303345),
                                fontSize: 7.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter"),
                          ),
                          Text(
                            "${weatherMainModel.mainInMain.humidity.toString()} km/h",
                            style: TextStyle(
                                color: const Color(0xff303345),
                                fontSize: 7.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter"),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 38.h,
                      width: 186.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: Colors.orangeAccent.shade100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Image.asset(
                              AppImages.water,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            "Humidity",
                            style: TextStyle(
                                color: const Color(0xff303345),
                                fontSize: 7.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter"),
                          ),
                          Text(
                            "${weatherMainModel.mainInMain.humidity.toString()}%",
                            style: TextStyle(
                                color: const Color(0xff303345),
                                fontSize: 7.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter"),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today",
                            style: TextStyle(
                                color: const Color(0xff313341),
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter"),
                          ),
                          Text(
                            "Tomorrow",
                            style: TextStyle(
                                color: const Color(0xffD6996B),
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter"),
                          ),
                          Text(
                            "Next 7 Days",
                            style: TextStyle(
                                color: const Color(0xffD6996B),
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter"),
                          ),
                          SvgPicture.asset(AppImages.arrow),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: SizedBox(
                        height: 3.h,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 1.h,
                                width: MediaQuery.of(context).size.width,
                                color: const Color(0xffE2A272),
                              ),
                            ),
                            Positioned(
                              left: 8,
                              child: Center(
                                child: Container(
                                  height: 3.h,
                                  width: 10.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff313341),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      height: 56.h,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: const [
                          ContainerWeek(text: "11:00", gradus: "19 °"),
                          ContainerWeek(text: "Now", gradus: "19 °"),
                          ContainerWeek(text: "13:00", gradus: "27 °"),
                          ContainerWeek(text: "14:00", gradus: "16 °"),
                          ContainerWeek(text: "15:00", gradus: "28 °"),
                          ContainerWeek(text: "16:00", gradus: "28 °"),
                          ContainerWeek(text: "17:00", gradus: "30 °"),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return Center(
              child: Text(snapshot.data!.error),
            );
          }

          return Center(
            child: Text(snapshot.error.toString()),
          );
        },
      ),
    );
  }
}
