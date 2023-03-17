import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:welcome_task/service/api/repository/donut_repository.dart';

import '../../constants/enums.dart';
import '../data/data_page.dart';
import '../home/home.dart';
import '../settings/settings_page.dart';
import '../sorting/sorting_page.dart';
import '../widgets/no_internet_view.dart';
import 'main_cubit.dart';
import 'main_state.dart';

class MainPage extends StatelessWidget {
  final Connectivity connectivityMonitor;
  final DonutRepository donutRepository;
  const MainPage({
    super.key,
    required this.connectivityMonitor,
    required this.donutRepository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainCubit, MainState>(
        buildWhen: (oldState, newState) => newState.shouldRebuild(oldState),
        builder: (ctx, state) {
          if (state.status == NetworkStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == NetworkStatus.disconnected) {
            return const NoInternetView();
          } else if (state.status == NetworkStatus.connected) {
            switch (state.selectedIndex) {
              case 0:
                return const HomePage();
              case 1:
                return DataPage(
                  donutRepository: donutRepository,
                );
              case 2:
                return const SortingPage();
              case 3:
                return const SettingsPage();
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          }
          return Container();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.watch<MainCubit>().state.selectedIndex,
          onTap: (index) {
            BlocProvider.of<MainCubit>(context, listen: false)
                .selectedPage(index);
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: "home".tr(),
              icon: const Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "data".tr(),
              icon: const Icon(Icons.data_usage),
            ),
            BottomNavigationBarItem(
              label: "sorting".tr(),
              icon: const Icon(Icons.sort_rounded),
            ),
            BottomNavigationBarItem(
              label: "settings".tr(),
              icon: const Icon(Icons.settings),
            ),
          ]),
    );
  }
}
