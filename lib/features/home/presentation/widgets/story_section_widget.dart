import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';

import '../../../../core/helper/image_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../screens/story_screen_privew.dart';

class StorySectionWidget extends StatefulWidget {
  const StorySectionWidget({super.key});

  @override
  State<StorySectionWidget> createState() => _StorySectionWidgetState();
}

class _StorySectionWidgetState extends State<StorySectionWidget> {
  Future<void> _pickAndNavigate(ImageSource source) async {
    context.pop();

    try {
      final pickedImage = await ImagePickerService().pickImage(source);

      if (pickedImage == null) {
        log("No image selected");
        return;
      }

      log("Image selected successfully");

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StoryPreviewScreen(selectedImage: pickedImage),
        ),
      );
    } catch (e) {
      log("Error picking image: $e");
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 70.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  if (index == 0) {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                context.translate(AppStrings.addStory),
                                style: CustomTextStyle.pacifico14,
                              ),
                              const Gap(10),
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: Text(
                                  context
                                      .translate(AppStrings.takePhotoOrVideo),
                                ),
                                onTap: () => _pickAndNavigate(ImageSource.camera),
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo),
                                title: Text(
                                  context.translate(AppStrings.chooseFromGallery),
                                ),
                                onTap: () => _pickAndNavigate(ImageSource.gallery),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Story"),
                        content: Text("You tapped on story $index!"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Close"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/profile_image/post2.jpg',
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    if (index == 0)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.w,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
