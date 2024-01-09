import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:weather_bloc/presentation/splash_screen.dart';

import 'bloc/splash/splash_bloc.dart';
import 'bloc/weather/weather_bloc.dart';
import 'data/repositories/weather_repositories.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return ScreenUtilInit(
      builder: (context,child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => SplashBloc()),
            BlocProvider(create: (_) => WeatherBloc(WeatherRepositoryImpl())),
          ],
          child: GetMaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: SplashScreen(),
          ),
        );
      }
    );
  }
}
