// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:welcome_task/feature/auth/cubit/auth_cubit.dart';
import 'package:welcome_task/feature/settings/cubit/settings_cubit.dart';
import 'package:welcome_task/feature/settings/show_map.dart';

import '../../constants/enums.dart';
import '../../model/city_model.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<Position?> findMyLocation(BuildContext context) async {
    final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
    bool serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
    bool userWentToSettings = false;

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      if (!serviceEnabled) {
        await geolocatorPlatform.isLocationServiceEnabled();
      }
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission =
          await Geolocator.requestPermission().onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("permissionDenided".tr()),
        ));
        return LocationPermission.denied;
      });
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          content: Text('permissionDenidedForever'.tr()),
          actions: [
            TextButton(
              onPressed: () async {
                userWentToSettings = true;
                await Geolocator.openLocationSettings()
                    .then((value) => Navigator.pop(context));
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      );

      if (userWentToSettings) {
        return null;
      }
    }
    
    try {
      Position position = await Geolocator.getCurrentPosition();
      debugPrint(
          '${position.latitude.toString()}, ${position.longitude.toString()}');
      return position;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("permissionDenided".tr()),
      ));
    }
    return null;
  }

  Future<City> showRandomCity() async {
    Random random = Random();
    List<City> listOfCities = [];
    List<Map<String, dynamic>> cities = [
      {
        'name': 'Tokyo',
        'latitude': 35.6740958,
        'longitude': 139.7002811,
      },
      {
        'name': 'New York City',
        'latitude': 40.6974034,
        'longitude': -74.1197624,
      },
      {
        'name': 'Paris',
        'latitude': 48.8588336,
        'longitude': 2.2769959,
      },
      {
        'name': 'London',
        'latitude': 51.5285582,
        'longitude': -0.2416789,
      },
      {
        'name': 'Dubai',
        'latitude': 25.0757464,
        'longitude': 54.9404104,
      },
      {
        'name': 'Singapore',
        'latitude': 1.3139961,
        'longitude': 103.7041666,
      },
      {
        'name': 'Istanbul',
        'latitude': 41.0052367,
        'longitude': 28.8720981,
      },
      {
        'name': 'Hong Kong',
        'latitude': 22.3526738,
        'longitude': 113.9876172,
      },
      {
        'name': 'Barcelona',
        'latitude': 41.3926467,
        'longitude': 2.0701498,
      },
      {
        'name': 'Rome',
        'latitude': 41.909986,
        'longitude': 12.3959166,
      }
    ];
    for (Map<String, dynamic> i in cities) {
      listOfCities.add(City.fromJson(i));
    }

    int randomIndex = random.nextInt(cities.length);
    final randomCity = listOfCities[randomIndex];
    debugPrint(randomCity.name);
    // await openMap(randomCity.latitude, randomCity.longitude);
    return randomCity;
  }

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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final position = await findMyLocation(context);
                          if (position != null) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: ((context) => AlertDialog(
                                    content: Text(
                                        'Latitude: ${position.latitude} Longitude: ${position.longitude}'),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("OK"))
                                    ],
                                  )),
                            );
                          }
                        },
                        child: const Text("Find Location"),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final city = await showRandomCity();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ShowMapPage(city: city)));
                        },
                        child: const Text("Show city"),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context).signOutRequest();
                          // BlocProvider.of<MainCubit>(context).selectedPage(0);
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
