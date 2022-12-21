import 'package:firebase_app_bloc/generated/l10n.dart';
import 'package:firebase_app_bloc/modules/authentication/pages/sign_up/pdf_view_page.dart';
import 'package:firebase_app_bloc/repositories/policy_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../assets/assets_path.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/stateless/stateless.dart';
import '../../cubits/cubits.dart';
import '../../widgets/authentication_widgets.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});
  static final debounce = Debounce(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          snackBarSuccess(context);
          Navigator.pop(context);
        } else if (state.status.isSubmissionFailure) {
          snackBarError(context, state.errorMessage.toString());
        }
      },
      child: Scaffold(
        backgroundColor: DarkTheme.greyScale900,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(S.current.signUp, style: TxtStyle.titleBig),
                ),
                buildTextFieldName(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: buildTextFieldEmail(),
                ),
                buildTextFieldPassword(),
                const SizedBox(height: 16),
                buildTextFieldConfirmedPassword(),
                const SizedBox(height: 20),
                Terms(
                  value: context.watch<SignUpCubit>().state.check,
                  onChanged: (value) =>
                      context.read<SignUpCubit>().checkChanged(value!),
                  onTap: () async {
                    final file = await PolicyRepository().loadPdfFirebase();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PDFViewerPage(file: file),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 28),
                BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    return ClassicButton(
                      onTap: state.status.isSubmissionInProgress
                          ? () {}
                          : () =>
                              context.read<SignUpCubit>().signUpFormSubmitted(),
                      width: size.width,
                      radius: 12,
                      widthRadius: 0,
                      colorRadius: state.status.isSubmissionInProgress
                          ? DarkTheme.greyScale600
                          : DarkTheme.primaryBlue600,
                      height: 52,
                      color: state.status.isSubmissionInProgress
                          ? DarkTheme.greyScale600
                          : DarkTheme.primaryBlue600,
                      child: Center(
                          child: state.status.isSubmissionInProgress
                              ? const CircularProgressIndicator()
                              : Text(S.current.signUp)),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).alreadyAccount,
                        style: TxtStyle.headline5),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        S.of(context).signIn,
                        style: TxtStyle.headline5.copyWith(
                          color: DarkTheme.primaryBlue600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldName() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return TextFieldName(
          key: const Key('signUpForm_nameInput_textField'),
          onChange: (name) =>
              debounce.run(() => context.read<SignUpCubit>().nameChanged(name)),
          errorText: state.name.invalid ? S.of(context).nameIsValid : null,
        );
      },
    );
  }

  Widget buildTextFieldEmail() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return TextFieldEmail(
          key: const Key('signUpForm_emailInput_textField'),
          onChange: (email) => debounce
              .run(() => context.read<SignUpCubit>().emailChanged(email)),
          errorText: state.email.invalid ? S.of(context).emailIsValid : null,
        );
      },
    );
  }

  Widget buildTextFieldPassword() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return PasswordTextField(
          label: S.of(context).password,
          hintText: S.of(context).enterYourPassword,
          key: const Key('signUpForm_passwordInput_textField'),
          onChange: (password) => debounce
              .run(() => context.read<SignUpCubit>().passwordChanged(password)),
          errorText:
              state.password.invalid ? S.of(context).passwordIsValid : null,
        );
      },
    );
  }

  Widget buildTextFieldConfirmedPassword() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return PasswordTextField(
          label: S.of(context).confirmPassword,
          hintText: S.of(context).enterYourConfirm,
          key: const Key('signUpForm_confirmPasswordInput_textField'),
          onChange: (confirmPassword) => debounce.run(() => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword)),
          errorText: state.confirmedPassword.invalid
              ? S.of(context).confirmPasswordIsValid
              : null,
          onEditingComplete: () =>
              context.read<SignUpCubit>().signUpFormSubmitted(),
        );
      },
    );
  }

  void snackBarError(BuildContext context, String e) {
    return showSnackBar(
      context,
      '${S.of(context).snackBarFailed(S.of(context).signUp)} : $e',
      Image.asset(AssetPath.iconClose, color: DarkTheme.red),
    );
  }

  void snackBarSuccess(BuildContext context) {
    return showSnackBar(
      context,
      S.of(context).snackBarSuccessfully(S.of(context).signUp),
      Image.asset(AssetPath.iconChecked, color: DarkTheme.green),
    );
  }
}
