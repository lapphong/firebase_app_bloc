part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class ChangeAvatarEvent extends EditProfileEvent {}

class OpenImagePickerEvent extends EditProfileEvent {
  final ImageSource imageSource;
  //display the selected image
  const OpenImagePickerEvent({required this.imageSource});

  @override
  List<Object> get props => [imageSource];
}

class NameChangedEvent extends EditProfileEvent {
  final String name;

  const NameChangedEvent({required this.name});

  @override
  List<Object> get props => [name];
}

class NameUnfocusedEvent extends EditProfileEvent {
  final String nameOld;

  const NameUnfocusedEvent({required this.nameOld});

  @override
  List<Object> get props => [nameOld];
}

class SaveProfileChanges extends EditProfileEvent {}
