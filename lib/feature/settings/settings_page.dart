import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:welcome_task/feature/settings/cubit/settings_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../constants/enums.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<Language>> items = [
      DropdownMenuItem(
        value: Language.english,
        child: Text('english'.tr()),
      ),
      DropdownMenuItem(
        value: Language.croatian,
        child: Text('croatian'.tr()),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("settings".tr()),
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    context
                        .read<SettingsCubit>()
                        .toggleSwitch(!state.isDarkTheme);
                    debugPrint('Dark mode: ${state.isDarkTheme.toString()}');
                  },
                  icon: state.isDarkTheme
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.sunny),
                  label: state.isDarkTheme
                      ? Text("darkMode".tr())
                      : Text("lightMode".tr()),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton<Language>(
                  key: ValueKey(state.dropdownValue),
                  value: state.dropdownValue,
                  items: items,
                  alignment: AlignmentDirectional.bottomCenter,
                  onChanged: (newValue) {
                    context.read<SettingsCubit>().setLanguage(newValue!);
                    if(newValue == Language.croatian) {
                      EasyLocalization.of(context)!.setLocale(const Locale('hr', 'HRV'));
                    } else {
                      EasyLocalization.of(context)!.setLocale(const Locale('en', 'US'));
                    }
                    debugPrint('Language: ${newValue.name}');
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
