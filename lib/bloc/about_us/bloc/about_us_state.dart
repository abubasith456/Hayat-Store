part of 'about_us_bloc.dart';

abstract class AboutUsState extends Equatable {
  const AboutUsState();

  @override
  List<Object> get props => [];
}

class AboutUsInitial extends AboutUsState {
  get shopLocation => LocationUtils.shopPosition();
  get cameraPosition => LocationUtils.cameraPosition();
}

class OnMapCreatedState extends AboutUsState {
  GoogleMapController controller;

  OnMapCreatedState({required this.controller});

  @override
  List<Object> get props => [];
}

class MapCameraPositionState extends AboutUsState {
  CameraPosition cameraPosition;

  MapCameraPositionState(this.cameraPosition);

  @override
  List<Object> get props => [cameraPosition];
}

class AboutUsMarkerState extends AboutUsState {}
