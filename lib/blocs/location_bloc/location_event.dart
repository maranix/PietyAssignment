part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

final class CheckLocationPermissions extends LocationEvent {
  const CheckLocationPermissions({
    this.request = false,
  });

  final bool request;

  @override
  List<Object?> get props => [request];
}

final class GetLocationPermissions extends LocationEvent {
  const GetLocationPermissions();
}

final class GetLocation extends LocationEvent {
  const GetLocation();
}
