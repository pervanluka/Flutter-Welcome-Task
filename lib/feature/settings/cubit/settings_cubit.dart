import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:welcome_task/constants/enums.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(
          const SettingsState(
            isDarkTheme: false,
            dropdownValue: Language.english,
          ),
        );

  void toggleSwitch(bool isDarkTheme) {
    emit(state.copyWith(isDarkTheme: isDarkTheme));
  }

  void setLanguage(Language newValue) {
    emit(state.copyWith(dropdownValue: newValue));
  }
}
