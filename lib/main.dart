import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:welcome_task/constants/enums.dart';
import 'package:welcome_task/feature/main/main_cubit.dart';
import 'package:welcome_task/feature/sorting/cubit/sort_cubit.dart';
import 'package:welcome_task/service/api/dio_client.dart';
import 'package:welcome_task/service/api/dio_service.dart';
import 'package:welcome_task/service/api/repository/donut_repository.dart';

import 'feature/data/cubit/data_cubit.dart';
import 'feature/data/data_page.dart';
import 'feature/home/home.dart';
import 'feature/sorting/sorting_page.dart';
import 'feature/main/main_state.dart';
import 'feature/widgets/no_internet_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DataCubit(
                DonutRepository(DioService(dioClient: DioClient(Dio())))),
          ),
          BlocProvider(
            create: (context) => SortCubit(),
          ),
          BlocProvider(
            create: (context) => MainCubit(Connectivity()),
          )
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainCubit, MainState>(
        buildWhen: (oldState, newState) => newState.shouldRebuild(oldState),
        builder: (context, state) {
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
                return const DataPage();
              case 2:
                return const SortingPage();
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
            BlocProvider.of<MainCubit>(context).selectedPage(index);
          },
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Data",
              icon: Icon(Icons.data_usage),
            ),
            BottomNavigationBarItem(
              label: "Sorting",
              icon: Icon(Icons.sort_rounded),
            ),
          ]),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<MainCubit, MainState>(
//         builder: (context, state) {
//           if (state.status == NetworkStatus.loading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state.status == NetworkStatus.disconnected) {
//             return const NoInternetView();
//           } else if (state.status == NetworkStatus.connected) {
//             switch (state.selectedIndex) {
//               case 0:
//                 return const HomePage();
//               case 1:
//                 return const DataPage();
//               case 2:
//                 return const SortingPage();
//               default:
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//             }
//           }
//           return Container();
//           // if (state is ConnectedState) {
//           //   switch (state.selectedIndex) {
//           //     case 0:
//           //       return const HomePage();
//           //     case 1:
//           //       return const DataPage();
//           //     case 2:
//           //       return const SortingPage();
//           //     default:
//           //       return const Center(
//           //         child: CircularProgressIndicator(),
//           //       );
//           //   }
//           // } else if (state is DisconnectedState) {
//           //   return const NoInternetView();
//           // } else {
//           //   return const Center(
//           //     child: CircularProgressIndicator(),
//           //   );
//           // }
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//           currentIndex: context.watch<MainCubit>().state.selectedIndex,
//           onTap: (index) {
//             BlocProvider.of<MainCubit>(context).selectedPage(index);
//           },
//           items: const [
//             BottomNavigationBarItem(
//               label: "Home",
//               icon: Icon(Icons.home),
//             ),
//             BottomNavigationBarItem(
//               label: "Data",
//               icon: Icon(Icons.data_usage),
//             ),
//             BottomNavigationBarItem(
//               label: "Sorting",
//               icon: Icon(Icons.sort_rounded),
//             ),
//           ]),
//     );
//   }
// }


