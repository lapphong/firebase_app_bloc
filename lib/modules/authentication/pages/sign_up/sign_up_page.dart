import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../utils/showSnackBar.dart';
import '../../../../assets/assets_path.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/debounce.dart';
import '../../../../widgets/stateless/stateless.dart';
import '../../cubits/cubits.dart';
import '../../widgets/authentication_widgets.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final debounce = Debounce(milliseconds: 1000);

  Widget buildTextFieldName() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return TextFieldName(
          key: const Key('signUpForm_nameInput_textField'),
          onChange: (name) =>
              debounce.run(() => context.read<SignUpCubit>().nameChanged(name)),
          errorText: state.name.invalid ? 'Name is valid' : null,
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
          errorText: state.email.invalid ? 'Email is valid' : null,
        );
      },
    );
  }

  Widget buildTextFieldPassword() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return PasswordTextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChange: (password) => debounce
              .run(() => context.read<SignUpCubit>().passwordChanged(password)),
          errorText: state.password.invalid ? 'Password is valid' : null,
        );
      },
    );
  }

  Widget buildTextFieldConfirmedPassword() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return PasswordTextField(
          label: 'Confirm Password',
          hintText: 'Enter your Confirm',
          key: const Key('signUpForm_confirmPasswordInput_textField'),
          onChange: (confirmPassword) => debounce.run(() => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword)),
          errorText: state.confirmedPassword.invalid
              ? 'Confirm Password is valid'
              : null,
          onEditingComplete: () =>
              context.read<SignUpCubit>().signUpFormSubmitted(),
        );
      },
    );
  }

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text('Sign Up', style: TxtStyle.titleBig),
                ),
                buildTextFieldName(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: buildTextFieldEmail(),
                ),
                buildTextFieldPassword(),
                const SizedBox(height: 16),
                buildTextFieldConfirmedPassword(),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 28),
                  child: Terms(size: size),
                ),
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
                              : const Text('Sign Up')),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ',
                        style: TxtStyle.headline5),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Sign in',
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

  void snackBarError(BuildContext context, String e) {
    return showSnackBar(
      context,
      'Sign up field : $e',
      Image.asset(AssetPath.iconClose, color: DarkTheme.red),
    );
  }

  void snackBarSuccess(BuildContext context) {
    return showSnackBar(
      context,
      "Sign up Successfully",
      Image.asset(AssetPath.iconChecked, color: DarkTheme.green),
    );
  }
}
