import 'package:dio/dio.dart';

import 'constants/constants.dart';
import 'dio_client.dart';

class DioService {
  final DioClient dioClient;

  DioService({required this.dioClient});

  Future<Response> getDonutApi() async {
    try {
      final Response response = await dioClient.get(AppEndpoits.baseUrl);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}