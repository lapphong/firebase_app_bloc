part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  const EditProfileState({
    required this.user,
    this.name = const Name.pure(),
    this.avatarPath,
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.imageSourceActionSheetIsVisible = false,
  });

  final User user;
  final Name name;
  final String? avatarPath;
  final FormzStatus status;
  final CustomError? errorMessage;
  final bool imageSourceActionSheetIsVisible;

  @override
  List<Object?> get props {
    return [
      user,
      name,
      avatarPath,
      status,
      errorMessage,
      imageSourceActionSheetIsVisible,
    ];
  }

  EditProfileState copyWith({
    User? user,
    Name? name,
    String? avatarPath,
    FormzStatus? status,
    CustomError? errorMessage,
    bool? imageSourceActionSheetIsVisible,
  }) {
    return EditProfileState(
      user: user ?? this.user,
      name: name ?? this.name,
      avatarPath: avatarPath ?? this.avatarPath,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      imageSourceActionSheetIsVisible: imageSourceActionSheetIsVisible ??
          this.imageSourceActionSheetIsVisible,
    );
  }
}
