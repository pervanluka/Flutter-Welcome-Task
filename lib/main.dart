// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:welcome_task/feature/auth/auth_check.dart';
import 'package:welcome_task/feature/auth/cubit/auth_cubit.dart';
import 'package:welcome_task/feature/main/main_cubit.dart';
import 'package:welcome_task/feature/settings/cubit/settings_cubit.dart';
import 'package:welcome_task/feature/sorting/cubit/sort_cubit.dart';
import 'package:welcome_task/service/api/dio_client.dart';
import 'package:welcome_task/service/api/dio_service.dart';
import 'package:welcome_task/service/api/repository/donut_repository.dart';
import 'package:welcome_task/service/firebase/auth_repository.dart';
import 'package:welcome_task/theme.dart';

import 'feature/data/cubit/data_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();

  runApp(
    RootApp(),
  );
}

class RootApp extends StatelessWidget {
  static late final RootApp instance;
  late final AuthRepository authRepository;
  late final AuthCubit authCubit;
  late final Connectivity connectivityMonitor;
  late final MainCubit mainCubit;
  late final Dio dio;
  late final DioClient dioClient;
  late final DioService dioService;
  late final DonutRepository donutRepository;
  late final DataCubit dataCubit;
  late final SortCubit sortCubit;
  late final SettingsCubit settingsCubit;

  RootApp({Key? key}) : super(key: key) {
    instance = this;
    authRepository = AuthRepository();
    authCubit = AuthCubit(authRepository: authRepository);
    connectivityMonitor = Connectivity();
    mainCubit = MainCubit(connectivity: connectivityMonitor);
    dio = Dio();
    dioClient = DioClient(dio);
    dioService = DioService(dioClient: dioClient);
    donutRepository = DonutRepository(dioService);
    dataCubit = DataCubit(donutRepository);
    sortCubit = SortCubit();
    settingsCubit = SettingsCubit();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authCubit),
          BlocProvider.value(value: settingsCubit),
          BlocProvider.value(value: mainCubit),
          BlocProvider.value(value: dataCubit),
          BlocProvider.value(value: sortCubit),
        ],
        child: EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const [Locale('en', 'US'), Locale('hr', 'HRV')],
          assetLoader: const RootBundleAssetLoader(),
          fallbackLocale: const Locale('en', 'US'),
          saveLocale: true,
          child: Builder(builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: BlocProvider.of<SettingsCubit>(context, listen: true)
                      .state
                      .isDarkTheme
                  ? lightTheme
                  : darkTheme,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: BlocProvider(
                create: (_) => authCubit,
                child: AuthCheck(
                  connectivityMonitor: connectivityMonitor,
                  donutRepository: donutRepository,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
