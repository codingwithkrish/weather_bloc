import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_bloc/services/location_services.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  LocationServices locationServices = LocationServices();
  SplashBloc() : super(SplashInitial()) {
    on<GetLocation>(_getLocation);
  }
  void _getLocation(GetLocation event, Emitter<SplashState> emit) async {
    emit(GetLocationLoading());
    bool checkPermission = await locationServices.handleLocationPermission();
    log("Location Permission $checkPermission");
    if (checkPermission) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      log("Lat:${position.latitude} , Lon:${position.longitude}");

      emit(GetLocationSuccess(
          lat: position.latitude.toString(),
          long: position.longitude.toString()));
    } else {
      emit(GetLocationFailure(
          message:
              'Unable To Fetch Location,Please try again after some time until you can not move ahead'));
    }
  }
}
