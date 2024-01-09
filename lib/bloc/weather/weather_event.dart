part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class WeatherFetchEvent extends WeatherEvent{
  final String latitude;
  final String longitude;
  final bool fetchPosition;

  WeatherFetchEvent({required this.latitude, required this.longitude,required this.fetchPosition});

}

class WeatherFetchEventByCity extends WeatherEvent{
  final String city;

  WeatherFetchEventByCity({required this.city});

}