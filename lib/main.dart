import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_bloc/modules/dashboardPage.dart';
import 'package:firebase_app_bloc/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/app/app_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'modules/authentication/cubits/sign_in/sign_in_cubit.dart';
import 'routes/routes.dart' as router;

import 'themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: DarkTheme.greyScale900,
      statusBarBrightness: Brightness.light,
    ));
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (context) => AppBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignInCubit>(
            create: (context) => SignInCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          theme: ThemeData(
            scaffoldBackgroundColor: DarkTheme.greyScale900,
            fontFamily: 'manrope',
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: DarkTheme.white,
                  displayColor: DarkTheme.white,
                ),
          ),
          home: const DashBoardPage(),
          onGenerateRoute: router.Routes.generateRoute,
        ),
      ),
    );
  }
}
