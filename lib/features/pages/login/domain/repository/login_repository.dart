import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:project_machine_test_2/features/pages/login/domain/model/login_model.dart';
import 'package:project_machine_test_2/features/resources/url_resources.dart';

class LoginRepository {
  final dio = Dio();
  Future<LoginModel> loginRepository(String countrycode, String phone) async {
    log("url checking ${UrlResources.login} post data ${"$countrycode ====== $phone"}");
    try {
      final formData = FormData.fromMap({"country_code": countrycode, "phone": phone});

      final response = await dio.post(
        UrlResources.login,
        data: formData,
        options: Options(
          headers: <String, String>{
            "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode! >= 200 || response.statusCode! <= 299) {
        log("login url ${UrlResources.login} response $response");
        final responseData = response.data;
        return LoginModel.fromJson(responseData);
      } else {
        log("Error response: ${response.toString()}");
        throw Exception("login Failed");
      }
    } on DioException catch (e) {
      log('Error during login: $e');
      final errorResponse = e.response?.data;
      log(errorResponse.toString());
      throw e.error.toString();
    }
  }
}
