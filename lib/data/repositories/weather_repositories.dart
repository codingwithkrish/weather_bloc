import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../services/request.dart';
import '../model/dart/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> getWeather(String lat, String lon,String units);
  Future<WeatherModel> getWeatherByCity(String cityName,String units);
}

class WeatherRepositoryImpl implements WeatherRepository {
   String apiKey = dotenv.env['API_KEY']!; // Add your API key here
   Request request = Request();

  WeatherRepositoryImpl();

  Future<WeatherModel> getWeatherByCity(String cityName,String units)async{
    final url = "weather?q=$cityName&appid=$apiKey";
    try{
      final response = await request.getData(url);
      if(response!=null){
        final Map<String, dynamic> json = jsonDecode(response.body);
        WeatherModel weatherModel = await getWeather(json["coord"]["lat"].toString(), json["coord"]["lon"].toString(), units);
        return weatherModel;
      }else{
        throw Exception('Failed to load weather data');
      }
    }catch (e){
      throw Exception(e);
    }
  }
  @override
  Future<WeatherModel> getWeather(String lat, String  lon,String units) async {
    final url = 'onecall?lat=$lat&lon=$lon&exclude=minutely&units=$units&appid=$apiKey';

    try{
      final response = await request.getData(url);
      if(response!=null){
        final Map<String, dynamic> json = jsonDecode(response.body);
        return WeatherModel.fromJson(json);
      }else{
        throw Exception('Failed to load weather data');
      }
    }catch (e){
      throw Exception(e);
    }



  }
}
