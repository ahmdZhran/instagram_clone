import 'package:flutter/material.dart';
import '../../../../core/helper/secure_storage_helper.dart';
import '../../../fcm_notification/fcm_services.dart';
import '../cubits/home_cubit/home_cubit.dart';
import '../widgets/custom_sliver_app_bar_widget.dart';
import '../widgets/posts_section_widget.dart';
import '../widgets/story_section_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeCubit _homeCubit = HomeCubit.getInstance();

  @override
  void initState() {
    _homeCubit.fetchPosts();
    super.initState();

    Future.microtask(() async {
      await _saveDeviceToken();
    });
  }

  Future<void> _saveDeviceToken() async {
    try {
      String? deviceToken = await FCMService.getDeviceToken();
      if (deviceToken != null) {
        final secureStorage = SecureStorageHelper();
        await secureStorage.save('device_token', deviceToken);
        debugPrint("FCM Device Token saved successfully: $deviceToken");
      } else {
        debugPrint("FCM Device Token is null!");
      }
    } catch (error) {
      debugPrint("Error saving FCM Device Token: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 80),
        child: CustomScrollView(
          clipBehavior: Clip.none,
          physics: BouncingScrollPhysics(),
          slivers: [
            CustomSliverAppBarWidget(),
            StorySectionWidget(),
            PostsSectionWidget()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //TODO need to think of it
    // HomeCubit.deleteInstance();
    super.dispose();
  }
}
