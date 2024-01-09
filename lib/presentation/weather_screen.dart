import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/presentation/constants/app_colors.dart';

import '../bloc/weather/weather_bloc.dart';
import '../data/repositories/weather_repositories.dart';
import 'constants/app_utils.dart';
import 'helper_widgets.dart';

class WeatherScreen extends StatelessWidget {
  final String lat, long;
  final WeatherBloc _weatherBloc;
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  WeatherScreen({super.key, required this.lat, required this.long})
      : _weatherBloc = WeatherBloc(WeatherRepositoryImpl()) {
    _weatherBloc.add(WeatherFetchEvent(
        latitude: lat, longitude: long, fetchPosition: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          bloc: _weatherBloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return (state is WeatherFetchLoading)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (state is WeatherFetchSuccess)
                    ? ListView(
                        children: [
                          citySearchTextField(_searchTextEditingController, () {
                            _weatherBloc.add(WeatherFetchEventByCity(
                                city: _searchTextEditingController.text));
                          }),
                          weatherInfoContainer(context, () async {
                            _weatherBloc.changeUnits();
                            _weatherBloc.add(WeatherFetchEvent(
                                latitude: lat,
                                longitude: long,
                                fetchPosition: false));
                          }, state.weatherModel.current!, state.city,
                              _weatherBloc.getUnits),
                          weatherHourlyContainer(
                              context,
                              state.weatherModel.hourly,
                              _weatherBloc.getUnits,
                              "${AppUtils().getDayFromDate(state.weatherModel.current!.dt!)} | ${AppUtils().getDateMMMd(state.weatherModel.current!.dt!)}"),
                          weatherDailyContainer(context,
                              state.weatherModel.daily, _weatherBloc.getUnits)
                        ],
                      )
                    : (state is WeatherFetchFailure)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                state.message,
                                style:
                                    TextStyle(color: AppColors.textColorDark),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    _weatherBloc.add(WeatherFetchEvent(
                                        latitude: lat,
                                        longitude: long,
                                        fetchPosition: false));
                                  },
                                  child: const Text(
                                      "Retry with Existing Location",
                                      style: TextStyle(
                                          color: AppColors.textColorDark)))
                            ],
                          )
                        : const Text("No Data");
          },
        ),
      ),
    );
  }
}
