import 'dart:async';
import 'dart:developer' as dev;

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

final class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationState()) {
    on<CheckLocationPermissions>(_onCheckPermissions);
    on<GetLocationPermissions>(_onGetPermissions);
    on<GetLocation>(_onGetLocation);
  }

  Future<void> _onCheckPermissions(
    CheckLocationPermissions event,
    Emitter<LocationState> emit,
  ) async {
    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      emit(state.copyWith(status: LocationStatus.disabled));
    }

    final permission = await Geolocator.checkPermission();

    return switch (permission) {
      LocationPermission.denied =>
        event.request ? add(const GetLocationPermissions()) : null,
      _ => emit(state.copyWith(status: LocationStatus.acquired)),
    };
  }

  Future<void> _onGetPermissions(
    GetLocationPermissions event,
    Emitter<LocationState> emit,
  ) async {
    final permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      emit(state.copyWith(status: LocationStatus.permissionsDenied));
    } else {
      emit(state.copyWith(status: LocationStatus.acquired));
    }
  }

  Future<void> _onGetLocation(
    GetLocation event,
    Emitter<LocationState> emit,
  ) async {
    add(const CheckLocationPermissions());

    final pos = await Geolocator.getLastKnownPosition();

    emit(state.copyWith(place: await _getPlaceFromPosition(pos)));

    try {
      final pos = await Geolocator.getCurrentPosition();

      emit(state.copyWith(place: await _getPlaceFromPosition(pos)));
    } on LocationServiceDisabledException {
      emit(state.copyWith(status: LocationStatus.disabled));
    } on Exception catch (e) {
      dev.log(
        e.toString(),
        name: 'Geolocator',
        error: e,
      );
    }
  }

  Future<geocoding.Placemark?> _getPlaceFromPosition(Position? pos) async {
    if (pos == null) {
      return null;
    }

    try {
      final place =
          await geocoding.placemarkFromCoordinates(pos.latitude, pos.longitude);

      return place.firstOrNull;
    } on PlatformException catch (e) {
      dev.log(
        e.toString(),
        name: 'Geocoding',
        error: e,
      );
      return null;
    }
  }

  Future<bool> openAppSettings() async {
    return Geolocator.openAppSettings();
  }

  Future<bool> openSettings() async {
    return Geolocator.openLocationSettings();
  }
}
