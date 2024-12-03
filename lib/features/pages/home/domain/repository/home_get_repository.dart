import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:project_machine_test_2/features/pages/home/domain/model/model.dart';
import 'package:project_machine_test_2/features/resources/pref_resources.dart';
import 'package:project_machine_test_2/features/resources/url_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository {
  final dio = Dio();
  Future<GetVideoModel> homeRepository() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tocken = prefs.getString(PrefResources.USER_TOCKEN);
      log("tocken is $tocken");

      final response = await dio.get(
        UrlResources.home,
        options: Options(
          headers: <String, String>{
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      log("home url ${UrlResources.home}${response.statusCode}");
      if (response.statusCode! >= 200 || response.statusCode! <= 299) {
        log("home url ${UrlResources.home} response $response");
        final responseData = response.data;
        return GetVideoModel.fromJson(responseData);
      } else {
        log("Error response: ${response.toString()}");
        throw Exception("home Failed");
      }
    } on DioException catch (e) {
      log('Error during home: $e');
      final errorResponse = e.response?.data;
      log("error response$errorResponse");
      throw e.error.toString();
    }
  }
}
