import 'package:flutter/material.dart';
import 'package:project_machine_test_2/features/pages/home/domain/model/calegories_model.dart';
import 'package:project_machine_test_2/features/pages/home/domain/model/model.dart';
import 'package:project_machine_test_2/features/pages/home/domain/repository/categories.dart';
import 'package:project_machine_test_2/features/pages/home/domain/repository/home_get_repository.dart';

class HomeController with ChangeNotifier {
  String? error;
  CategoriesModel? categoriesModel;
  GetVideoModel? getVideoModel;

  bool isLoading = false;
  bool isSuccess = false;

  Future<void> categorylistRepository() async {
    isLoading = true;
    notifyListeners();
    final response = await CategorylistRepository().categorylistRepository();
    categoriesModel = response;
    isLoading = false;
    isSuccess = true;
    notifyListeners();
  }

  Future<void> homeRepository() async {
    isLoading = true;
    notifyListeners();
    final response = await HomeRepository().homeRepository();
    getVideoModel = response;
    isLoading = false;
    notifyListeners();
  }
}
