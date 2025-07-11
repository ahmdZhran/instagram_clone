import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/reels/presentation/cubits/cubit/reel_cubit.dart';
import 'package:instagram_clone/features/reels/presentation/widgets/reel_item_widget.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  late PageController _pageController;
  final ReelCubit _reelCubit = ReelCubit.getInstance();
  @override
  void initState() {
    super.initState();
    _reelCubit.fetchReels();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ReelCubit, ReelState>(
        bloc: _reelCubit,
        builder: (context, state) {
          if (state is ReelLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReelFailure) {
            return Center(child: Text("Error: ${state.errorMessage}"));
          } else if (state is ReelSuccess) {
            if (state.reels.isEmpty) {
              return const Center(child: Text("No reels available"));
            }

            return PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: state.reels.length,
              itemBuilder: (context, index) {
                return ReelItemWidget(
                  reel: state.reels[index],
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
