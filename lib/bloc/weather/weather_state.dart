part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherFetchLoading extends WeatherState{}
class WeatherFetchSuccess extends WeatherState{
  final WeatherModel weatherModel;
  final String city;

  WeatherFetchSuccess({required this.weatherModel,required this.city});
}
class WeatherFetchFailure extends WeatherState{
  final String message;

  WeatherFetchFailure({required this.message});

}