import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app_bloc/resources/theme_manager.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final _themeManager = ThemeManager();
  ThemeCubit() : super(ThemeState.initial());

  Future<void> changeTheme(bool theme) async {
    if (theme) {
      await _themeManager.saveTheme(theme);
      emit(state.copyWith(appTheme: AppTheme.dark));
    } else {
      await _themeManager.saveTheme(theme);
      emit(state.copyWith(appTheme: AppTheme.light));
    }
  }

  Future<void> getTheme() async {
    final themeMode = await _themeManager.getTheme();
    if (themeMode != true) {
      emit(state.copyWith(appTheme: AppTheme.light));
    }
  }
}
