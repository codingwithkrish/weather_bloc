import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_bloc/data/model/dart/weather_model.dart';
import 'package:weather_bloc/data/repositories/weather_repositories.dart';
import 'package:weather_bloc/services/location_services.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  final _units = BehaviorSubject<String>.seeded("imperial");
  Stream<String> get outUnits=>_units.stream;
  Function(String) get inUnits=>_units.sink.add;
  String get getUnits =>_units.value;


  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetchEvent>(_getWeather);
    on<WeatherFetchEventByCity>(_getWeatherByCity);
  }
  void changeUnits(){
    if(_units.value=="imperial"){
      _units.value="metric";
    }else{
      _units.value="imperial";
    }
  }


  void _getWeather(WeatherFetchEvent event, Emitter<WeatherState> emit) async{
    emit(WeatherFetchLoading());

    String lat = event.latitude;
    String long = event.longitude;
    try{
      log(_units.value);
      if(event.fetchPosition){
        Position position = await LocationServices().getParticularLocation();
        lat = position.latitude.toString();
        long = position.longitude.toString();

      }
      final weather = await weatherRepository.getWeather(lat,long,_units.value);
      String city = (await LocationServices().getCityFromLocation(weather.lat!, weather.lon!))!;
       emit(WeatherFetchSuccess(weatherModel: weather,city: city));
    }catch (e){
      emit(WeatherFetchFailure(message: e.toString()));
    }
  }

  void _getWeatherByCity(WeatherFetchEventByCity event, Emitter<WeatherState> emit) async{
    emit(WeatherFetchLoading());
    try{
      log(_units.value);

      final weather = await weatherRepository.getWeatherByCity(event.city,_units.value);
      String city = (await LocationServices().getCityFromLocation(weather.lat!, weather.lon!))!;
    emit(WeatherFetchSuccess(weatherModel: weather,city: city));
    }catch (e){
    emit(WeatherFetchFailure(message: e.toString()));
    }
  }
}
