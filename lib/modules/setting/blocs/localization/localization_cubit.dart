import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app_bloc/resources/localization_managet.dart';
import 'package:flutter/material.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final _localizationManager = LocalizationManager();
  LocalizationCubit() : super(LocalizationState.initial());

  Future<void> changeLang(int lang) async {
    switch (lang) {
      case 0:
        await _localizationManager.saveLocalization(lang);
        emit(state.copyWith(locale: const Locale('en'), index: lang));
        break;
      case 1:
        await _localizationManager.saveLocalization(lang);
        emit(state.copyWith(locale: const Locale('fr'), index: lang));
        break;
      case 2:
        await _localizationManager.saveLocalization(lang);
        emit(state.copyWith(locale: const Locale('de'), index: lang));
        break;
      case 3:
        await _localizationManager.saveLocalization(lang);
        emit(state.copyWith(locale: const Locale('id'), index: lang));
        break;
      case 4:
        await _localizationManager.saveLocalization(lang);
        emit(state.copyWith(locale: const Locale('it'), index: lang));
        break;
      case 5:
        await _localizationManager.saveLocalization(lang);
        emit(state.copyWith(locale: const Locale('ja', 'JP'), index: lang));
        break;
      case 6:
        await _localizationManager.saveLocalization(lang);
        emit(state.copyWith(locale: const Locale('ru'), index: lang));
        break;
    }
  }

  Future<void> getLang() async {
    final lang = await _localizationManager.getLocalization();
    switch (lang) {
      case 0:
        emit(state.copyWith(locale: const Locale('en'), index: lang));
        break;
      case 1:
        emit(state.copyWith(locale: const Locale('fr'), index: lang));
        break;
      case 2:
        emit(state.copyWith(locale: const Locale('de'), index: lang));
        break;
      case 3:
        emit(state.copyWith(locale: const Locale('id'), index: lang));
        break;
      case 4:
        emit(state.copyWith(locale: const Locale('it'), index: lang));
        break;
      case 5:
        emit(state.copyWith(locale: const Locale('ja', 'JP'), index: lang));
        break;
      case 6:
        emit(state.copyWith(locale: const Locale('ru'), index: lang));
        break;
    }
  }
}
