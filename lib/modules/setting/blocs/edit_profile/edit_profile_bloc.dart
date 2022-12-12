import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app_bloc/models/models.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../repositories/profile_repository.dart';
import '../../../../repositories/storage_repository.dart';
import '../../../../utils/formz/name_formz.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ProfileRepository profileRepository;
  final StorageRepository storageRepository;
  final User user;

  final ImagePicker _picker = ImagePicker();

  EditProfileBloc({
    required this.profileRepository,
    required this.storageRepository,
    required this.user,
  }) : super(EditProfileState(user: user)) {
    on<ChangeAvatarEvent>((event, emit) {
      emit(state.copyWith(imageSourceActionSheetIsVisible: true));
    });
    on<OpenImagePickerEvent>(_onOpenImagePicker);
    on<CloseOptionImageEvent>((event, emit) {
      emit(state.copyWith(imageSourceActionSheetIsVisible: false));
    });
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
    print(pickedImage.path);

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
    final name = Name.dirty(state.name.value);
    emit(state.copyWith(name: name, status: Formz.validate([name])));
  }

  Future<void> _onSaveProfileChanges(
    SaveProfileChanges event,
    Emitter<EditProfileState> emit,
  ) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      final linkImage = await storageRepository.uploadImageToStorage(
          file: File(state.avatarPath!));

      final updateUser = state.user.copyWith(
        name: state.name.value,
        profileImage: linkImage,
      );

      await profileRepository.update(user: updateUser);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          errorMessage: e,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
