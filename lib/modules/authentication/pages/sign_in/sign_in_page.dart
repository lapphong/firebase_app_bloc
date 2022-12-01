import 'package:firebase_app_bloc/modules/authentication/pages/sign_in/sign_in_form.dart';
import 'package:firebase_app_bloc/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/cubits.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SignInCubit(authRepository: context.read<AuthRepository>()),
      child: const SignInForm(),
    );
  }
}
