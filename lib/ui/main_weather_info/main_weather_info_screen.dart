import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/data/models/main/lat_lon.dart';
import 'package:weather_app/data/models/main/weather_main_model.dart';
import 'package:weather_app/data/models/universal_data.dart';
import 'package:weather_app/data/network/api_provider.dart';
import 'package:weather_app/ui/hourly_daily/hourly_daily_screen.dart';
import 'package:weather_app/utils/app_images.dart';

class MainWeatherInfoScreen extends StatefulWidget {
  const MainWeatherInfoScreen({Key? key, required this.latLong}) : super(key: key);

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
      appBar: AppBar(
        title: const Text("Weather Info screen"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const HourlyDailyScreen();
                }));
              },
              icon: const Icon(Icons.next_plan))
        ],
      ),
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
                      padding: EdgeInsets.symmetric(horizontal: 11.w,vertical: 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            AppImages.search,
                            height: 24.h,
                            width: 24.h,
                          ),
                          SvgPicture.asset(
                            AppImages.menu,
                            height: 24.h,
                            width: 24.h,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h,),
                    SizedBox(height: 48.h,width: 108.w,child: Text(""),)

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
