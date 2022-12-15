part of 'localization_cubit.dart';

class LocalizationState extends Equatable {
  final Locale locale;
  final int index;
  const LocalizationState({
    required this.locale,
    required this.index,
  });

  factory LocalizationState.initial() {
    return const LocalizationState(locale: Locale('en'), index: 0);
  }

  @override
  List<Object> get props => [locale,index];

  LocalizationState copyWith({
    Locale? locale,
    int? index,
  }) {
    return LocalizationState(
      locale: locale ?? this.locale,
      index: index?? this.index
    );
  }

  @override
  String toString() => 'LocalizationState(locale: $locale,index: $index)';
}
