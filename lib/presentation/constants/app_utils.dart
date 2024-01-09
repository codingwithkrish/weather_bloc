import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_bloc/presentation/constants/lottie_files.dart';

class AppUtils {
  showAlertDialog(String title, String message) {
    Get.defaultDialog(
      title: title,
      content: Text(message),
      textConfirm: 'OK',
      onConfirm: () {
        // Do something when the user presses the "OK" button
        Get.back(); // Close the dialog
      },
    );
  }

  DateTime unixDateToLocalDate(int unixTimestamp) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
    return dateTime;
  }
  String? getLottie(int num){
    switch(num){
      case >=200&&<300:
        return LottieFiles.files["thunderstorm"];
        break;
      case >=300&&<400:
        return LottieFiles.files["default"];
      case >=500&&<600:
        return LottieFiles.files["rain"];
      case >=600&&<700:
        return LottieFiles.files["snow"];
      case >=700&&<800:
        return LottieFiles.files["mist"];
      case 800:
        return LottieFiles.files["clearSky"];
      case >=801&&<900:
        return LottieFiles.files["clouds"];
      default:
        return LottieFiles.files["default"];

    }
  }
  String getTimehmma(int date){
    DateTime dateTime = unixDateToLocalDate(date);

    return  DateFormat('h:mm a').format(dateTime);
  }
  String getDateEEE(int date){
    DateTime dateTime = unixDateToLocalDate(date);
    return DateFormat('EEE').format(dateTime);
  }

  String getDayFromDate(int date) {
    DateTime dateTime = unixDateToLocalDate(date);
    int weekday = dateTime.weekday;
    return getWeekdayString(weekday);
  }

  String getDateMMMd(int date) {
    DateTime dateTime = unixDateToLocalDate(date);
    return DateFormat('MMM d').format(dateTime);
  }

  String getWeekdayString(int weekday) {
    // Convert the weekday integer to a corresponding string
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Invalid weekday';
    }
  }
}
