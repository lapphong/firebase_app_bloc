part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class ChangeAvatarEvent extends EditProfileEvent {}

class OpenImagePickerEvent extends EditProfileEvent {}

class ProvideImagePathEvent extends EditProfileEvent {
  final String avatarPath;

  const ProvideImagePathEvent({required this.avatarPath});

  @override
  List<Object> get props => [avatarPath];
}

class NameChangedEvent extends EditProfileEvent {
  final String name;

  const NameChangedEvent({required this.name});

  @override
  List<Object> get props => [name];
}

class NameUnfocusedEvent extends EditProfileEvent {}

class SaveProfileChanges extends EditProfileEvent {}
