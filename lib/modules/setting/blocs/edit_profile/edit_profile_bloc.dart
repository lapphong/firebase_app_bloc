import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app_bloc/models/models.dart';
import 'package:formz/formz.dart';

import '../../../../repositories/profile_repository.dart';
import '../../../../utils/formz/name_formz.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ProfileRepository profileRepository;

  EditProfileBloc({required this.profileRepository})
      : super(const EditProfileState()) {
    on<ChangeAvatarEvent>(_onChangeAvatar);
    on<OpenImagePickerEvent>(_onOpenImagePicker);
    on<ProvideImagePathEvent>(_onProvideImagePath);
    on<NameChangedEvent>(_onNameChanged);
    on<NameUnfocusedEvent>(_onNameUnfocused);
    on<SaveProfileChanges>(_onSaveProfileChanges);
  }

  void _onNameChanged(
    NameChangedEvent event,
    Emitter<EditProfileState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(name: name, status: Formz.validate([name])));
  }

  void _onNameUnfocused(
    NameUnfocusedEvent event,
    Emitter<EditProfileState> emit,
  ) {
    final name = Name.dirty(state.name.value);
    emit(state.copyWith(name: name, status: Formz.validate([name])));
  }
}
