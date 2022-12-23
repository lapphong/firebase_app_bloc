import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app_bloc/models/models.dart';
import 'package:firebase_app_bloc/repositories/user_repository/user_base.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../utils/formz/name_formz.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserBase userBase;
  final User user;

  final ImagePicker _picker = ImagePicker();

  EditProfileBloc({
    required this.userBase,
    required this.user,
  }) : super(EditProfileState(user: user)) {
    on<ChangeAvatarEvent>((event, emit) {
      emit(state.copyWith(imageSourceActionSheetIsVisible: true));
    });
    on<OpenImagePickerEvent>(_onOpenImagePicker);
    on<NameChangedEvent>(_onNameChanged);
    on<NameUnfocusedEvent>(_onNameUnfocused);
    on<SaveProfileChanges>(_onSaveProfileChanges);
  }

  Future<void> _onOpenImagePicker(
    OpenImagePickerEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(imageSourceActionSheetIsVisible: false));

    final pickedImage = await _picker.pickImage(
      source: event.imageSource,
      imageQuality: 90,
    );

    if (pickedImage == null) return;
    emit(state.copyWith(avatarPath: pickedImage.path));
  }

  void _onNameChanged(NameChangedEvent event, Emitter<EditProfileState> emit) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(name: name, status: Formz.validate([name])));
  }

  void _onNameUnfocused(
    NameUnfocusedEvent event,
    Emitter<EditProfileState> emit,
  ) {
    final nameOld = Name.dirty(event.nameOld);
    emit(state.copyWith(name: nameOld, status: Formz.validate([nameOld])));
  }

  Future<void> _onSaveProfileChanges(
    SaveProfileChanges event,
    Emitter<EditProfileState> emit,
  ) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      final linkImage = state.avatarPath != null
          ? await userBase.uploadImageToStorage(
              file: File(state.avatarPath!))
          : user.profileImage;

      final updateUser = state.user.copyWith(
        name: state.name.value,
        profileImage: linkImage,
      );

      await userBase.updateProfile(user: updateUser);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on CustomError catch (e) {
      emit(
        state.copyWith(errorMessage: e, status: FormzStatus.submissionFailure),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionCanceled));
    }
  }
}
