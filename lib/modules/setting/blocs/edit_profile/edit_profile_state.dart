part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  const EditProfileState({
    this.name = const Name.pure(),
    this.avatarPath,
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Name name;
  final String? avatarPath;
  final FormzStatus status;
  final CustomError? errorMessage;

  @override
  List<Object?> get props => [name, avatarPath, status, errorMessage];

  EditProfileState copyWith({
    User? user,
    Name? name,
    String? avatarPath,
    FormzStatus? status,
    CustomError? errorMessage,
  }) {
    return EditProfileState(
      name: name ?? this.name,
      avatarPath: avatarPath ?? this.avatarPath,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
