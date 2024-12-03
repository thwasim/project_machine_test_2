// ignore_for_file: use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:project_machine_test_2/features/constant/loading_screen.dart';
import 'package:project_machine_test_2/features/constant/snack_bar.dart';
import 'package:project_machine_test_2/features/pages/add_feeds/controller/add_feeds_controller.dart';
import 'package:project_machine_test_2/features/pages/home/controller/home_controller.dart';
import 'package:project_machine_test_2/features/pages/home/presentation/home_screen.dart';
import 'package:project_machine_test_2/features/resources/color_resources.dart';
import 'package:provider/provider.dart';

class AddFeedsScreen extends StatefulWidget {
  const AddFeedsScreen({super.key});

  @override
  State<AddFeedsScreen> createState() => _AddFeedsScreenState();
}

class _AddFeedsScreenState extends State<AddFeedsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeController>(context, listen: false).categorylistRepository();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddFeedsController>(
      builder: (context, addFeedsController, child) {
        if (addFeedsController.isSuccess == true) {
          Navigator.of(context).pop();
        }
        return Scaffold(
          backgroundColor: ColorResources.blackColor,
          appBar: AppBar(
            backgroundColor: ColorResources.blackColor,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: ColorResources.whiteColor, width: 1)),
                  child: Center(
                    child: Icon(Icons.arrow_back_ios_new_outlined, color: ColorResources.whiteColor, size: 18),
                  ),
                ),
              ),
            ),
            centerTitle: false,
            title: Text("Add Feeds", style: TextStyle(color: ColorResources.whiteColor, fontSize: 16)),
            actions: [
              if (addFeedsController.isLoading)
                const LoadingScreen()
              else
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () async {
                      FormData formData = FormData.fromMap({
                        "video": addFeedsController.videoFile == null ? '' : await MultipartFile.fromFile(addFeedsController.videoFile!.path),
                        "image": addFeedsController.selectedImage == null ? '' : await MultipartFile.fromFile(addFeedsController.selectedImage!.path, filename: "document.jpg"),
                        "desc": addFeedsController.descriptionController.text,
                        "category": addFeedsController.selectedChipIds.toString(),
                      });

                      if (addFeedsController.descriptionController.text.isEmpty ||
                          addFeedsController.videoFile == null ||
                          addFeedsController.selectedImage == null ||
                          addFeedsController.selectedChipIds.isEmpty) {
                        showSnackBar(context, "All Field is required");
                      } else {
                        addFeedsController.addFeedRepository(formData);
                      }
                    },
                    child: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: ColorResources.redColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: ColorResources.redColor, width: 1),
                      ),
                      child: Center(
                        child: Text("Share Post", style: TextStyle(color: ColorResources.whiteColor, fontSize: 13)),
                      ),
                    ),
                  ),
                ),
              if (addFeedsController.error != null)
                Text(
                  addFeedsController.error!,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      addFeedsController.uploadVideoSelection(context);
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(15),
                      padding: const EdgeInsets.all(12),
                      dashPattern: const [6, 0, 2, 3],
                      color: ColorResources.whiteColor.withOpacity(0.3),
                      child: Container(
                        height: 230,
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                        child: addFeedsController.videoFile == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.upload_file_outlined, color: ColorResources.whiteColor),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Select a video from Gallery",
                                    style: TextStyle(color: ColorResources.whiteColor.withOpacity(0.5)),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    addFeedsController.videoFile!.path.toString(),
                                    style: TextStyle(color: ColorResources.whiteColor.withOpacity(0.5)),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      addFeedsController.uploadImageSelection(context, imageType: 'document');
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(15),
                      padding: const EdgeInsets.all(12),
                      dashPattern: const [6, 0, 2, 3],
                      color: ColorResources.whiteColor.withOpacity(0.3),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                        child: addFeedsController.selectedImage == null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.image_outlined, color: ColorResources.whiteColor),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Add a Thumbnail",
                                    style: TextStyle(color: ColorResources.whiteColor.withOpacity(0.5)),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 300,
                                    child: Text(
                                      addFeedsController.selectedImage!.path.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: ColorResources.whiteColor.withOpacity(0.5)),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Add Description",
                    style: TextStyle(fontSize: 18, color: ColorResources.whiteColor),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: addFeedsController.descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Enter Description",
                      hintStyle: TextStyle(fontSize: 16, color: ColorResources.whiteColor.withOpacity(0.3)),
                    ),
                    style: TextStyle(fontSize: 18, color: ColorResources.whiteColor.withOpacity(0.4)),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories This Project",
                        style: TextStyle(fontSize: 18, color: ColorResources.whiteColor),
                      ),
                      Row(
                        children: [
                          Text(
                            "View All",
                            style: TextStyle(color: ColorResources.whiteColor.withOpacity(0.4)),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: ColorResources.whiteColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(Icons.arrow_forward_ios_rounded, color: ColorResources.whiteColor.withOpacity(0.4), size: 12),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: Consumer<HomeController>(
                      builder: (context, value, child) {
                        if (value.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ListView.builder(
                          itemCount: value.categoriesModel?.categories?.length ?? 0,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final category = value.categoriesModel!.categories![index];
                            final isSelected = addFeedsController.selectedChipIds.contains(category.id);

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 2.0,
                                children: [
                                  ChoiceChip(
                                    label: Text(
                                      category.title.toString(),
                                      style: TextStyle(
                                        color: isSelected ? ColorResources.blackColor : ColorResources.whiteColor,
                                      ),
                                    ),
                                    selected: isSelected,
                                    selectedColor: ColorResources.whiteColor,
                                    backgroundColor: ColorResources.blackColor,
                                    onSelected: (selected) {
                                      addFeedsController.toggleChipSelection(category.id!);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
