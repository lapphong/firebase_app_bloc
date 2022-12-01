import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_app_bloc/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/blocs.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'routes/routes.dart' as router;

import 'themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authRepository = AuthRepository(
    firebaseFirestore: FirebaseFirestore.instance,
    firebaseAuth: FirebaseAuth.instance,
  );
  await authRepository.user.first;
  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;
  final AuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: DarkTheme.greyScale900,
      statusBarBrightness: Brightness.light,
    ));
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (context) => AppBloc(
          authRepository: context.read<AuthRepository>(),
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      initialRoute: '/',
      onGenerateRoute: router.Routes.generateRoute,
    );
  }
}
