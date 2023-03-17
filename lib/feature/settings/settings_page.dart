import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:welcome_task/feature/auth/cubit/auth_cubit.dart';
import 'package:welcome_task/feature/main/main_cubit.dart';
import 'package:welcome_task/feature/settings/cubit/settings_cubit.dart';

import '../../constants/enums.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<Language>> items = [
      DropdownMenuItem(
        value: Language.english,
        child: Row(
          children: [
            Image.asset(
              'assets/img/Flag_of_the_United_States.svg.png',
              width: 30,
              height: 20,
            ),
            const SizedBox(
              width: 5,
            ),
            Text('english'.tr()),
          ],
        ),
      ),
      DropdownMenuItem(
        value: Language.croatian,
        child: Row(
          children: [
            Image.asset(
              'assets/img/Flag_of_Croatia.svg.webp',
              height: 20,
              width: 30,
            ),
            const SizedBox(
              width: 5,
            ),
            Text('croatian'.tr()),
          ],
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("settings".tr()),
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3 -
                        (kToolbarHeight - kBottomNavigationBarHeight),
                  ),
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
                    value: EasyLocalization.of(context)!.currentLocale ==
                            const Locale('en', 'US')
                        ? Language.english
                        : Language.croatian,
                    items: items,
                    alignment: AlignmentDirectional.center,
                    onChanged: (newValue) {
                      context.read<SettingsCubit>().setLanguage(newValue!);
                      if (newValue == Language.croatian) {
                        EasyLocalization.of(context)!
                            .setLocale(const Locale('hr', 'HRV'));
                      } else {
                        EasyLocalization.of(context)!
                            .setLocale(const Locale('en', 'US'));
                      }
                      debugPrint('Language: ${newValue.name}');
                    },
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context).signOutRequest();
                          BlocProvider.of<MainCubit>(context).selectedPage(0);
                        },
                        icon: const Icon(Icons.logout),
                        label: Text("signOut".tr())),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
