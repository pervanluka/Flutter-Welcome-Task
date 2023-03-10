import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:welcome_task/feature/sorting/cubit/sort_cubit.dart';

class SortingPage extends StatelessWidget {
  const SortingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final button = context.read<SortCubit>();

    // return BlocProvider(
    //   create: (_) => SortCubit(),
    //   child: BlocBuilder<SortCubit, SortState>(builder: ((context, state) {
    //     return Scaffold(body: Center(child: Text("anfkea")),);
    //   })),
    // );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sorting"),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<SortCubit, SortState>(
          builder: (ctx, state) {
            if (state is SortInitial) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (() => ctx.read<SortCubit>().onButtonPressed()),
                    child: const Text('Press me'),
                  ),
                ],
              );
            } else if (state is SortLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SortReady) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (() => ctx.read<SortCubit>().onButtonPressed()),
                    child: const Text('Press me'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(state.timeTaken),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
