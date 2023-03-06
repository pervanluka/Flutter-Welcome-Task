import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:welcome_task/feature/main_cubit.dart';

import 'feature/data/data_page.dart';
import 'feature/home/home.dart';
import 'feature/sorting/sorting_page.dart';
import 'feature/main_state.dart';
import 'my_app_observer.dart';

void main() {
  Bloc.observer = const MyAppObserver();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<MainCubit>(
        create: (_) => MainCubit(),
        child: Scaffold(
          body: BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              switch (state.selectedIndex) {
                case 0:
                  return const HomePage();
                case 1:
                  return const DataPage();
                case 2:
                  return const SortingPage();
                default:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: context.select((MainCubit cubit) => cubit.state.selectedIndex),
            onTap: (index) {
                context.read<MainCubit>().selectTab(index);
              },
              items: const [
                BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
                BottomNavigationBarItem(
                  label: "Data",
                  icon: Icon(Icons.data_usage),
                ),
                BottomNavigationBarItem(
                  label: "Sorting",
                  icon: Icon(Icons.sort_rounded),
                ),
              ]),
        ),
      ),
    );
  }
}
