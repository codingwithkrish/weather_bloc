import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_bloc/presentation/constants/app_colors.dart';
import 'package:weather_bloc/presentation/constants/app_utils.dart';

import '../data/model/dart/weather_model.dart';
Widget citySearchTextField(TextEditingController controller,VoidCallback onPressed){
  return      Padding(
    padding: EdgeInsets.only(
        left: 16.w, right: 16.w, top: 16.h),
    child: TextField(
      controller: controller,
      style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: AppColors.textColorDark),
      cursorColor: AppColors.blueColor,
      decoration: InputDecoration(
          hintText: 'Search',
          suffixIcon: IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.search)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.w.h),
            borderSide: const BorderSide(
                color: AppColors.blueColor), // Set border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.w.h),
            borderSide: const BorderSide(
                color: AppColors.blueColor), // Set focused border color
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.w.h),
            borderSide: const BorderSide(
                color: AppColors.blueColor), // Set focused border color
          )),
    ),
  );

}

Widget weatherInfoContainer(BuildContext context, VoidCallback onChangedUnit,
    CurrentWeather currentWeather, String city, String units) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w.h),
        gradient: const LinearGradient(
          colors: [Color(0xff62B8F6), Color(0xff2C79C1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: onChangedUnit,
                icon: Icon(
                  Icons.track_changes_rounded,
                  color: AppColors.textColorDay,
                  size: 25.w.h,
                )),
            Text(units=="imperial"?"metric":"imperial",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.textColorDay,
                  fontWeight: FontWeight.bold,
                )),
          ],
          title: Text(city,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textColorDay,
                fontWeight: FontWeight.w600,
              )),
          leading: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onChangedUnit,
                icon: Icon(
                  Icons.refresh,
                  color: AppColors.textColorDay,
                  size: 25.w.h,
                ),
              ),
            ],
          ),
        ),
        LottieBuilder.network(
            AppUtils().getLottie(currentWeather.weather!.first.id!)!,
          height: 200.h,
          width: 200.w,
        ),
        Text("${currentWeather.temp}${units == "imperial" ? " °F" : " °C"}",
            style: TextStyle(
              fontSize: 25.sp,
              color: AppColors.textColorDay,
              fontWeight: FontWeight.bold,
            )),
        Text(
            "${AppUtils().getDayFromDate(currentWeather.dt!)} | ${AppUtils().getDateMMMd(currentWeather.dt!)}",
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textColorDay,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          height: 10.h,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 1.h,
            decoration: const BoxDecoration(color: AppColors.textColorDay)),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListTile(
                subtitle: Text("Desc",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textColorDay,
                      fontWeight: FontWeight.w500,
                    )),
                title: Text(
                    "${currentWeather.weather!.first.description}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textColorDay,
                      fontWeight: FontWeight.w700,
                    )),
                leading: Icon(
                  Icons.wind_power_sharp,
                  color: AppColors.textColorDay,
                  size: 25.w.h,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                subtitle: Text("Visibility",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textColorDay,
                      fontWeight: FontWeight.w500,
                    )),
                title: Text("${currentWeather.visibility} m",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textColorDay,
                      fontWeight: FontWeight.w700,
                    )),
                leading: Icon(
                  Icons.visibility,
                  color: AppColors.textColorDay,
                  size: 25.w.h,
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListTile(
                subtitle: Text("Humidity",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textColorDay,
                      fontWeight: FontWeight.w500,
                    )),
                title: Text("${currentWeather.humidity}%",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textColorDay,
                      fontWeight: FontWeight.w700,
                    )),
                leading: Icon(
                  Icons.water_drop_outlined,
                  color: AppColors.textColorDay,
                  size: 25.w.h,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                subtitle: Text("Pressure",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textColorDay,
                      fontWeight: FontWeight.w500,
                    )),
                title: Text("${currentWeather.pressure} hPa",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textColorDay,
                      fontWeight: FontWeight.w700,
                    )),
                leading: Icon(
                  Icons.gas_meter,
                  color: AppColors.textColorDay,
                  size: 25.w.h,
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}

Widget weatherHourlyContainer(BuildContext context,List<HourlyWeather>? hourly,String units,String date) {
  return Container(
    margin: EdgeInsets.only(bottom: 16.h),
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
    decoration: const BoxDecoration(
        gradient: LinearGradient(
      colors: [Color(0xff62B8F6), Color(0xff2C79C1)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    )),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Hourly ForeCast || ${date}",
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textColorDay,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 70.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: hourly!.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  Text(AppUtils().getTimehmma(hourly[i].dt!),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textColorDay,
                        fontWeight: FontWeight.w700,
                      )),
                  Icon(
                    Icons.cloud_rounded,
                    color: AppColors.textColorDay,
                  ),
                  Text("${hourly[i].temp}${units == "imperial" ? " °F" : " °C"}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textColorDay,
                        fontWeight: FontWeight.w500,
                      ))
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(padding: EdgeInsets.symmetric(horizontal: 8.w));
            },
          ),
        )
      ],
    ),
  );
}

Widget weatherDailyContainer(BuildContext context,List<DailyWeather>? daily,String units) {
  return Container(
    margin: EdgeInsets.only(bottom: 16.h),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.w.h),
            bottomRight: Radius.circular(20.w.h)),
        gradient: const LinearGradient(
          colors: [Color(0xff62B8F6), Color(0xff2C79C1)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        )),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Forcats for ${daily!.length} Days",
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textColorDay,
              fontWeight: FontWeight.w500,
            )),
        SizedBox(
          height: 10.h,
        ),
        ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,

            itemBuilder: (context, i) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(AppUtils().getDateEEE(daily[i].dt!),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textColorDay,
                        fontWeight: FontWeight.w500,
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_rounded,
                        color: AppColors.textColorDay,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text("${daily[i].humidity}% humidity",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textColorDay,
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  ),
                  Text("${daily[i].temp!.min}${units == "imperial" ? " °F" : " °C"}/${daily[i].temp!.max}${units == "imperial" ? " °F" : " °C"}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textColorDay,
                        fontWeight: FontWeight.w400,
                      ))
                ],
              );
            },
            separatorBuilder: (context, i) {
              return Padding(padding: EdgeInsets.symmetric(vertical: 8.h));
            },
            itemCount: daily.length)
      ],
    ),
  );
}
