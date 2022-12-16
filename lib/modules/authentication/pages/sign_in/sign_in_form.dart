import 'package:firebase_app_bloc/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../assets/assets_path.dart';
import '../../../../routes/route_name.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/stateless/stateless.dart';
import '../../cubits/cubits.dart';
import '../../widgets/authentication_widgets.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});
  static final debounce = Debounce(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          snackBarSuccess(context);
        } else if (state.status.isSubmissionFailure) {
          snackBarError(context, state.errorMessage.toString());
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text('Udemy.', style: TxtStyle.titleBig),
                const SizedBox(height: 16),
                buildTextFieldEmail(),
                const SizedBox(height: 16),
                buildTextFieldPassword(),
                buildForgotPassword(),
                const SizedBox(height: 16),
                BlocBuilder<SignInCubit, SignInState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    return ClassicButton(
                      onTap: state.status.isSubmissionInProgress
                          ? () {}
                          : () => context
                              .read<SignInCubit>()
                              .logInEmailWithCredentials(),
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
                              : Text(S.current.signIn)),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  S.current.orContinueWithSocialAccount,
                  style: TxtStyle.headline5.copyWith(
                    color: DarkTheme.greyScale500,
                  ),
                ),
                const SizedBox(height: 24),
                ClassicButton(
                  onTap: () {},
                  width: size.width,
                  widthRadius: 0,
                  radius: 12,
                  height: 52,
                  color: DarkTheme.primaryBlueButton900,
                  colorRadius: DarkTheme.primaryBlueButton900,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AssetPath.iconGoogle),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(S.current.signInWithGoogle),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ClassicButton(
                  onTap: () {},
                  width: size.width,
                  widthRadius: 0,
                  radius: 12,
                  height: 52,
                  color: DarkTheme.primaryBlueButton900,
                  colorRadius: DarkTheme.primaryBlueButton900,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AssetPath.iconFacebook),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(S.current.signInWithFacebook),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // ClassicButton(
                //   onTap: () {},
                //   width: size.width,
                //   widthRadius: 0,
                //   radius: 12,
                //   height: 52,
                //   color: DarkTheme.primaryBlueButton900,
                //   colorRadius: DarkTheme.primaryBlueButton900,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: const [
                //       Icon(Icons.phone, color: DarkTheme.green),
                //       Padding(
                //         padding: EdgeInsets.only(left: 20.0),
                //         child: Text('Sign In with Phone number'),
                //       ),
                //     ],
                //   ),
                // ),
                Text(S.of(context).donotHaveAnAccount,
                    style: TxtStyle.headline5),
                TextButton(
                  key: const Key('loginForm_createAccount_flatButton'),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(RouteName.signUpPage),
                  child: Text(
                    S.of(context).createHere,
                    style: TxtStyle.headline5
                        .copyWith(color: DarkTheme.primaryBlue600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldEmail() {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFieldEmail(
          key: const Key('loginForm_emailInput_textField'),
          onChange: (email) => debounce
              .run(() => context.read<SignInCubit>().emailChanged(email)),
          errorText: state.email.invalid ? S.of(context).emailIsValid : null,
        );
      },
    );
  }

  Widget buildTextFieldPassword() {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return PasswordTextField(
          label: S.of(context).password,
          hintText: S.of(context).enterYourPassword,
          key: const Key('loginForm_passwordInput_textField'),
          onChange: (password) => debounce
              .run(() => context.read<SignInCubit>().passwordChanged(password)),
          errorText:
              state.password.invalid ? S.of(context).passwordIsValid : null,
          onEditingComplete: () =>
              context.read<SignInCubit>().logInEmailWithCredentials(),
        );
      },
    );
  }

  Align buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          S.current.forgotPassword,
          style: TxtStyle.headline4.copyWith(color: DarkTheme.primaryBlue600),
        ),
      ),
    );
  }

  void snackBarError(BuildContext context, String e) {
    return showSnackBar(
      context,
      '${S.of(context).snackBarFailed(S.of(context).signIn)} : $e',
      Image.asset(AssetPath.iconClose, color: DarkTheme.red),
    );
  }

  void snackBarSuccess(BuildContext context) {
    return showSnackBar(
      context,
      S.of(context).snackBarSuccessfully(S.of(context).signIn),
      Image.asset(AssetPath.iconChecked, color: DarkTheme.green),
    );
  }
}
