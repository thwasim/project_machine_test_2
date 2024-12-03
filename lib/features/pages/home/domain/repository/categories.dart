import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:project_machine_test_2/features/pages/home/domain/model/calegories_model.dart';
import 'package:project_machine_test_2/features/resources/url_resources.dart';

class CategorylistRepository {
  final dio = Dio();
  Future<CategoriesModel> categorylistRepository() async {
    try {
      final response = await dio.get(
        UrlResources.categorylist,
        options: Options(
          headers: <String, String>{
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      log("categorylist url ${UrlResources.categorylist}${response.statusCode}");
      if (response.statusCode! >= 200 || response.statusCode! <= 299) {
        log("categorylist url ${UrlResources.categorylist} response $response");
        final responseData = response.data;
        return CategoriesModel.fromJson(responseData);
      } else {
        log("Error response: ${response.toString()}");
        throw Exception("categorylist Failed");
      }
    } on DioException catch (e) {
      log('Error during categorylist: $e');
      final errorResponse = e.response?.data;
      log("error response$errorResponse");
      throw e.error.toString();
    }
  }
}
