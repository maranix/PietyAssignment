part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class DeleteLocationData extends ProfileEvent {
  const DeleteLocationData();
}
