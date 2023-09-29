import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'location_event.dart';
part 'location_state.dart';

final class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationInitial()) {
    on<GetLocationPermissions>(_onGetPermissions);
  }

  Future<void> _onGetPermissions(GetLocationPermissions event, Emitter<LocationState> emit) async {}
}
