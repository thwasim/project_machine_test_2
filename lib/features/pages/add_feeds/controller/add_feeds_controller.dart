// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_machine_test_2/features/constant/snack_bar.dart';
import 'package:project_machine_test_2/features/pages/add_feeds/domain/model/model.dart';
import 'package:project_machine_test_2/features/pages/add_feeds/domain/repository/add_feed_repository.dart';
import 'package:project_machine_test_2/features/resources/extensions.dart';

class AddFeedsController with ChangeNotifier {
  File? selectedImage;
  File? videoFile;
  final picker = ImagePicker();

  bool isLoading = false;
  bool isSuccess = false;

  String? error;
  FeedAddedModel? feedAddedModel;
  TextEditingController descriptionController = TextEditingController();
  List<int> selectedChipIds = [];

  void toggleChipSelection(int chipId) {
    if (selectedChipIds.contains(chipId)) {
      selectedChipIds.remove(chipId);
    } else {
      selectedChipIds.add(chipId);
    }
    notifyListeners();
  }

  Future<void> addFeedRepository(FormData formData) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await AddFeedRepository().addFeedRepository(formData);
      feedAddedModel = response;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      isSuccess = true;
      notifyListeners();
    }
  }

  updatePickImage(cropImage) {
    selectedImage = cropImage;
    notifyListeners();
  }

  uploadImageSelection(BuildContext context, {required String imageType}) async {
    await Permission.camera.status.then(
      (value) async {
        if (value.isGranted) {
          await Utils.pickImageFromGallery().then((pickedFile) async {
            if (pickedFile == null) return;
            File cropImage = File(pickedFile.path);
            if (imageType.toLowerCase() == 'document') {
              updatePickImage(cropImage);
            }
          });
        } else if (value.isDenied) {
          Permission.camera.request();
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Camera Permission'),
              content: const Text('This app needs camera access to take pictures for upload photo'),
              actions: [
                MaterialButton(
                  child: const Text('Deny'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                MaterialButton(
                  child: const Text('Settings'),
                  onPressed: () {
                    openAppSettings();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future uploadVideoSelection(BuildContext context) async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery, preferredCameraDevice: CameraDevice.front, maxDuration: const Duration(minutes: 10));
    XFile? xfilePick = pickedFile;
    updatePickVideo(xfilePick, pickedFile, context);
  }

  updatePickVideo(XFile? xfilePick, XFile? pickedFile, BuildContext context) {
    if (xfilePick != null) {
      videoFile = File(pickedFile!.path);
      notifyListeners();
    } else {
      showSnackBar(context, "Nothing is selected");
    }
    notifyListeners();
  }
}
