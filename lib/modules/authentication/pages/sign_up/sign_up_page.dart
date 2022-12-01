import 'package:firebase_app_bloc/modules/authentication/pages/sign_up/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repositories/auth_repository.dart';
import '../../cubits/cubits.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SignUpCubit(authRepository: context.read<AuthRepository>()),
      child: const SignUpForm(),
    );
  }
}
