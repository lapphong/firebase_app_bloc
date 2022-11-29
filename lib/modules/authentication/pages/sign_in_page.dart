import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../utils/showSnackBar.dart';
import '../../../assets/assets_path.dart';
import '../../../themes/themes.dart';
import '../../../widgets/stateless/stateless.dart';
import '../widgets/authentication_widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  //----------------------------------------------------------------------------

  Widget buildTextFieldEmail() {
    return TextFieldEmail(
      onChange: (value) {},
      emailController: _emailController,
      emailFocusNode: _emailFocusNode,
    );
  }

  bool _onChanged = false;
  bool _isObscure = true;
  Widget buildTextFieldPassword() {
    return PasswordTextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      onChange: (value) {
        _onChanged = true;
        setState(() {});
      },
      //errorText: 'password is invalid',
      obscureText: _isObscure,
      suffixIcon: _passwordController.text.isEmpty
          ? Container(width: 0)
          : Align(
              widthFactor: 0.5,
              heightFactor: 0.5,
              child: _onChanged
                  ? CustomAvatar(
                      width: 20,
                      height: 15,
                      assetName: _isObscure
                          ? AssetPath.iconEye
                          : AssetPath.iconHideEye,
                      onTap: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  : const Text(''),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Text('Ontari.', style: TxtStyle.titleBig),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: buildTextFieldEmail(),
              ),
              buildTextFieldPassword(),
              buildForgotPassword(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ClassicButton(
                  onTap: () {},
                  width: size.width,
                  radius: 12,
                  widthRadius: 0,
                  colorRadius: DarkTheme.primaryBlue600,
                  height: 52,
                  color: DarkTheme.primaryBlue600,
                  child: const Center(child: Text('Sign in')),
                ),
              ),
              Text(
                'Or continue with social account',
                style: TxtStyle.headline5.copyWith(
                  color: DarkTheme.greyScale500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: ClassicButton(
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
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text('Sign In with Google'),
                      ),
                    ],
                  ),
                ),
              ),
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
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text('Sign In with Facebook'),
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
                  children: const [
                    Icon(Icons.phone, color: DarkTheme.green),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text('Sign In with Phone number'),
                    ),
                  ],
                ),
              ),
              //buildGoToSignUpPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Align buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Forgot password?',
          style: TxtStyle.headline4.copyWith(
            color: DarkTheme.primaryBlue600,
          ),
        ),
      ),
    );
  }

  // Padding buildGoToSignUpPage(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 10.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const Text('Don\'t have an account? ', style: TxtStyle.headline5),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => const SignUpPage(),
  //               ),
  //             );
  //           },
  //           child: Text(
  //             'Create Here',
  //             style: TxtStyle.headline5.copyWith(
  //               color: DarkTheme.primaryBlue600,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void snackBarError(PlatformException e) {
    return showSnackBar(
      context,
      'Sign in cancelled : ${e.message}',
      Image.asset(AssetPath.iconClose, color: DarkTheme.red),
    );
  }

  void snackBarSuccess() {
    return showSnackBar(
      context,
      "Sign in Successfully",
      Image.asset(AssetPath.iconChecked, color: DarkTheme.green),
    );
  }
}
