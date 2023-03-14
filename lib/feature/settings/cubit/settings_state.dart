part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool isDarkTheme;
  final Language dropdownValue;
  const SettingsState({required this.isDarkTheme, required this.dropdownValue});

  @override
  List<Object> get props => [isDarkTheme, dropdownValue];

  SettingsState copyWith({bool? isDarkTheme, Language? dropdownValue}) {
    return SettingsState(
        isDarkTheme: isDarkTheme ?? this.isDarkTheme,
        dropdownValue: dropdownValue ?? this.dropdownValue);
  }
}
