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
    this.place,
  });

  final LocationStatus status;
  final geocoding.Placemark? place;

  LocationState copyWith({
    LocationStatus? status,
    geocoding.Placemark? place,
  }) {
    return LocationState(
      status: status ?? this.status,
      place: place ?? this.place,
    );
  }

  @override
  List<Object?> get props => [
        status,
        place,
      ];
}
