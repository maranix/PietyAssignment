part of 'location_bloc.dart';

enum LocationStatus {
  unknown,
  disabled,
  permissionsDenied,
  acquired,
}

final class LocationState extends Equatable {
  const LocationState({
    this.status = LocationStatus.unknown,
    this.lat,
    this.lon,
  });

  final LocationStatus status;
  final double? lat;
  final double? lon;

  LocationState copyWith({
    LocationStatus? status,
    double? lat,
    double? lon,
  }) {
    return LocationState(
      status: status ?? this.status,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  @override
  List<Object?> get props => [
        status,
        lat,
        lon,
      ];
}
