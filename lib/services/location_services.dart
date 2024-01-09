import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_bloc/presentation/constants/app_utils.dart';

class LocationServices{
  Future<String?> getCityFromLocation(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark currentPlace = placemarks[0];
        String city = currentPlace.locality ?? '';
        return city;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Position> getParticularLocation()async{
    try{
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    }catch (e){
      throw Exception(e);
    }

  }
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AppUtils().showAlertDialog("Error", "Location services are disabled. Please enable the services");

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        AppUtils().showAlertDialog("Error", "Location permissions are denied");

       return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      AppUtils().showAlertDialog("Error", "Location permissions are permanently denied, we cannot request permissions.");


      return false;
    }
    return true;
  }
}