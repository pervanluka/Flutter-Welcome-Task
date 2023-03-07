import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:welcome_task/feature/data/cubit/data_state.dart';
import 'package:welcome_task/service/api/dio_client.dart';
import 'package:welcome_task/service/api/dio_service.dart';
import 'package:welcome_task/service/api/repository/donut_repository.dart';

import '../widgets/custom_container.dart';
import 'cubit/data_cubit.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imgList = [
      'https://img.taste.com.au/f0YNQK61/taste/2016/11/donut-cake-70028-1.jpeg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIBHxVoy85TZvTLpekKG-s4RkyORkJYIcvVECuPABBgzkklVM31tOgKAtr7WuoPumjPCQ&usqp=CAU',
      'https://images.heb.com/is/image/HEBGrocery/003334251?fit=constrain,1&wid=800&hei=800&fmt=jpg&qlt=85,0&resMode=sharp2&op_usm=1.75,0.3,2,0'
    ];
    return BlocProvider(
      create: (_) =>
          DataCubit(DonutRepository(DioService(dioClient: DioClient(Dio())))),
      child: BlocBuilder<DataCubit, DataState>(builder: ((context, state) {
        if (state is DonutLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DonutErrorState) {
          return const Center(child: Text("Something went wrong!"));
        } else if (state is DonutLoadedState) {
          
          return ListView.separated(
              itemBuilder: ((context, index) {
                return CustomContainer(item: state.donuts[index], src: imgList[index]);
              }),
              separatorBuilder: (_, __) => const SizedBox(
                    width: 20,
                  ),
              itemCount: state.donuts.length);
        } else {
          return Container();
        }
      })),
    );
  }
}
