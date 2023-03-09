import 'package:dio/dio.dart';

import '../../../model/donut_model.dart';
import '../dio_exception.dart';
import '../dio_service.dart';

class DonutRepository {
  final DioService donutApi;

  DonutRepository(this.donutApi);

  Future<List<DonutItem>> getDonutRequested() async {
    try {
      List<DonutItem> list = [];
      final response = await donutApi.getDonutApi();
      var data = response.data;
      for (Map<String,dynamic> i in data) {
        list.add(DonutItem.fromJson(i));
      }
      return list;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
