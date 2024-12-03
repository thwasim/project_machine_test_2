import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:project_machine_test_2/features/pages/add_feeds/domain/model/model.dart';
import 'package:project_machine_test_2/features/resources/pref_resources.dart';
import 'package:project_machine_test_2/features/resources/url_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFeedRepository {
  final dio = Dio();
  Future<FeedAddedModel> addFeedRepository(FormData formData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tocken = prefs.getString(PrefResources.USER_TOCKEN);
      log("tocken is $tocken");

      final response = await dio.post(
        UrlResources.addFeed,
        data: formData,
        options: Options(
          headers: <String, String>{
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $tocken",
          },
        ),
      );
      log("addFeed url ${UrlResources.addFeed}${response.statusCode}");
      if (response.statusCode! >= 200 || response.statusCode! <= 299) {
        log("addFeed url ${UrlResources.addFeed} response $response");
        final responseData = response.data;
        return FeedAddedModel.fromJson(responseData);
      } else {
        log("Error response: ${response.toString()}");
        throw Exception("addFeed Failed");
      }
    } on DioException catch (e) {
      log('Error during addFeed: $e');
      final errorResponse = e.response?.data;
      log("error response$errorResponse");
      throw e.error.toString();
    }
  }
}
