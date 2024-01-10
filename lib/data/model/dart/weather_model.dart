import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    double? lat,
    double? lon,
    String? timezone,
    int? timezoneOffset,
    CurrentWeather? current,
    List<HourlyWeather>? hourly,
    List<DailyWeather>? daily,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}

@freezed
class CurrentWeather with _$CurrentWeather {
  const factory CurrentWeather(
      {int? dt,
      int? sunrise,
      int? sunset,
      double? temp,
      double? feelsLike,
      int? pressure,
      int? humidity,
      double? dewPoints,
      double? uvi,
      int? clouds,
      int? visibility,
      double? windSpeed,
      int? windDeg,
      List<WeatherDescription>? weather}) = _CurrentWeather;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);
}

@freezed
class HourlyWeather with _$HourlyWeather {
  const factory HourlyWeather({
    int? dt,
    double? temp,
    double? feelsLike,
    int? pressure,
    int? humidity,
    double? dewPoint,
    double? uvi,
    int? clouds,
    int? visibility,
    double? windSpeed,
    int? windDeg,
    double? windGust,
    List<WeatherDescription>? weather,
    double? pop,
    Rain? rain,
  }) = _HourlyWeather;

  factory HourlyWeather.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherFromJson(json);
}

@freezed
class DailyWeather with _$DailyWeather {
  const factory DailyWeather({
    int? dt,
    int? sunrise,
    int? sunset,
    int? moonrise,
    int? moonset,
    double? moonPhase,
    Temp? temp,
    FeelsLike? feelsLike,
    int? pressure,
    int? humidity,
    double? dewPoint,
    double? windSpeed,
    int? windDeg,
    double? windGust,
    List<WeatherDescription>? weather,
    int? clouds,
    double? pop,
    double? uvi
  }) = _DailyWeather;

  factory DailyWeather.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherFromJson(json);
}

@freezed
class WeatherDescription with _$WeatherDescription {
  const factory WeatherDescription({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) = _WeatherDescription;

  factory WeatherDescription.fromJson(Map<String, dynamic> json) =>
      _$WeatherDescriptionFromJson(json);
}

@freezed
class Rain with _$Rain {
  const factory Rain({
    @JsonKey(name: '1h') double? oneHour,
  }) = _Rain;

  factory Rain.fromJson(Map<String, dynamic> json) => _$RainFromJson(json);
}
@freezed
class Temp with _$Temp {
  factory Temp({
    @JsonKey(name: 'day') double? day,
    @JsonKey(name: 'min') double? min,
    @JsonKey(name: 'max') double? max,
    @JsonKey(name: 'night') double? night,
    @JsonKey(name: 'eve') double? eve,
    @JsonKey(name: 'morn') double? morn,
  }) = _Temp;

  factory Temp.fromJson(Map<String, dynamic> json) => _$TempFromJson(json);
}

@freezed
class FeelsLike with _$FeelsLike {
  factory FeelsLike({
    @JsonKey(name: 'day') double? day,
    @JsonKey(name: 'night') double? night,
    @JsonKey(name: 'eve') double? eve,
    @JsonKey(name: 'morn') double? morn,
  }) = _FeelsLike;

  factory FeelsLike.fromJson(Map<String, dynamic> json) => _$FeelsLikeFromJson(json);
}