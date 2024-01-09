import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:weather_bloc/presentation/constants/app_colors.dart';
import 'package:weather_bloc/presentation/weather_screen.dart';

import '../bloc/splash/splash_bloc.dart';
import 'constants/app_utils.dart';

class SplashScreen extends StatelessWidget {
  final SplashBloc _splashBloc;

  SplashScreen({super.key}) :_splashBloc= SplashBloc() {
    _splashBloc.add(GetLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SplashBloc, SplashState>(
          bloc: _splashBloc,
          listener: (context, state) {
            // TODO: implement listener
            if(state is GetLocationFailure){
              AppUtils().showAlertDialog("Error", state.message);

            }
            if(state is GetLocationSuccess){
              Get.offAll(()=>WeatherScreen(lat: state.lat, long: state.long,));
            }
          },
          builder: (BuildContext context, SplashState state) {
            if(state is GetLocationFailure){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style:
                    const TextStyle(color: AppColors.textColorDark),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _splashBloc.add(GetLocation());
                      },
                      child: const Text(
                          "Retry",
                          style: TextStyle(
                              color: AppColors.textColorDark)))
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.network(
                    "https://lottie.host/e3bf6ee3-d79c-4169-a4af-e1328c873379/NLrPuujFx5.json"),
                Container(
                  alignment: Alignment.center,
                  child: Text("Weather Gather App",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: AppColors.niceColor,
                        fontWeight: FontWeight.w800,
                      )),
                )
              ],
            );
          },

        ),
      ),
    );
  }
}
