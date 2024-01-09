part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class GetLocationLoading extends SplashState {}

class GetLocationSuccess extends SplashState {
  final String lat;
  final String long;

  GetLocationSuccess({required this.lat, required this.long});
}

class GetLocationFailure extends SplashState {
  final String message;

  GetLocationFailure({required this.message});
}
