# weather_bloc
 Weather App Made With Bloc  
 package used for  
 code generators  freezed_annotation: ^2.4.1,freezed: ^2.4.6,build_runner: ^2.4.7  ,json_serializable: 6.7.1,json_annotation: ^4.8.1  
  state management - flutter_bloc: ^8.1.3  
  responsiveness-flutter_screenutil: ^5.9.0  
  location - geolocator: ^10.1.0,geocoding: ^2.1.1  
  navigation,dialog - getx  
  animation - lottie: ^2.7.0  
  Safety Measuer - flutter_dotenv: ^5.1.0  
  step1) splash screen first fetches the location of user , then send it to weather screen  
  step2) if location permission is denied then able to move ahead  
  step3) splash screen uses SplashBloc for bloc  
  step4) in WeatherScreen proper weather is fetched with WeatherBloc , the model is in WeatherModel used freezed for it.  
  All the fetching of weather are done in WeatherRepository .  
  app_colors.dart include color used in the app  
  app_utils.dart includes neccassry things required in making of app like dialog, date etc.  
  lottie_files.dart include the lottie files  
  helper_widgets.dart include the helpe widget for the weather_Screen.dart  
  request.dart make the network call for api  
  location_services.dart send the permission and give the location of user  
  error_handling.dart handles the error of network  
  .env store the API_KEY that is the safety measure  
  
