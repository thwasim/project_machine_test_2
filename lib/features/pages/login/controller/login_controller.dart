import 'package:flutter/material.dart';
import 'package:project_machine_test_2/features/pages/login/domain/model/login_model.dart';
import 'package:project_machine_test_2/features/pages/login/domain/repository/login_repository.dart';
import 'package:project_machine_test_2/features/resources/pref_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController with ChangeNotifier {
  bool isLoading = false;
  String? error;
  LoginModel? user;
  TextEditingController phoneController = TextEditingController();

  Future<void> login() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await LoginRepository().loginRepository("+91", phoneController.text.trim());
      await saveDatasFromSharedPrefernces(response);
      user = response;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveDatasFromSharedPrefernces(LoginModel response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefResources.USER_TOCKEN, response.token!.access.toString());
  }
}
