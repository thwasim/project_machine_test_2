// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:project_machine_test_2/features/pages/add_feeds/controller/add_feeds_controller.dart';
import 'package:project_machine_test_2/features/pages/home/presentation/video_widget.dart';
import 'package:project_machine_test_2/features/resources/extensions.dart';
import 'package:provider/provider.dart';
import 'package:project_machine_test_2/features/pages/add_feeds/presentation/add_feeds_screen.dart';
import 'package:project_machine_test_2/features/pages/home/controller/home_controller.dart';
import 'package:project_machine_test_2/features/resources/color_resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeController>(context, listen: false).homeRepository();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello Maria",
                          style: TextStyle(color: ColorResources.whiteColor, fontSize: 18),
                        ),
                        Text(
                          "Welcome back to Section",
                          style: TextStyle(color: ColorResources.whiteColor.withOpacity(0.5)),
                        ),
                      ],
                    ),
                    Icon(Icons.person, size: 40, color: ColorResources.whiteColor),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 80,
                child: Consumer<HomeController>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: value.getVideoModel?.categoryDict?.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final category = value.getVideoModel?.categoryDict?[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            label: Text(
                              category?.title ?? "",
                              style: TextStyle(
                                color: ColorResources.whiteColor,
                              ),
                            ),
                            backgroundColor: ColorResources.blackColor,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: Consumer<HomeController>(
                  builder: (context, homeController, child) {
                    if (homeController.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final results = homeController.getVideoModel?.results ?? [];
                    return ListView.builder(
                      itemCount: results.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final video = results[index];
                        final videoUrl = video.video;

                        if (videoUrl == null || videoUrl.isEmpty) {
                          return Center(
                            child: Text(
                              "Invalid video URL",
                              style: TextStyle(color: ColorResources.whiteColor),
                            ),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(video.user?.image ??
                                            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        video.user?.name ?? "User Name",
                                        style: TextStyle(
                                          color: ColorResources.whiteColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        Utils.timeAgoDetailed(video.createdAt.toString()),
                                        style: TextStyle(
                                          color: ColorResources.whiteColor.withOpacity(0.5),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              FeedVideoPlayer(videoUrl: videoUrl),
                              const SizedBox(height: 8),
                              Text(
                                video.description ?? "",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorResources.whiteColor.withOpacity(0.5),
                                ),
                              ),
                              const Divider(color: Colors.white54),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorResources.redColor,
        onPressed: () {
          final addFeedsController = Provider.of<AddFeedsController>(context, listen: false);
          addFeedsController.isSuccess = false;
          addFeedsController.descriptionController.text = "";
          addFeedsController.videoFile = null;
          addFeedsController.selectedImage = null;
          addFeedsController.selectedChipIds = [];
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const AddFeedsScreen()));
        },
        child: Icon(Icons.add, color: ColorResources.whiteColor),
      ),
    );
  }
}
