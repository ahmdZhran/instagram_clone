import 'package:flutter/material.dart';

import '../../data/models/story_model.dart';
import '../screens/add_story_screen.dart';

class StorySectionWidget extends StatefulWidget {
  const StorySectionWidget({super.key});

  @override
  State<StorySectionWidget> createState() => _StorySectionWidgetState();
}

class _StorySectionWidgetState extends State<StorySectionWidget> {
  final List<StoryModel>? stories = [];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: stories?.length ?? 0,
          itemBuilder: (context, index) {
            if (index == 0) {
              // Add Story button
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddStoryScreen()),
                  );
                },
                child: const CircleAvatar(
                  child: Icon(Icons.add),
                ),
              );
            }
            // Existing story items
            return const StoryItem();
          },
        ),
      ),
    );
  }
}

class StoryItem extends StatelessWidget {
  const StoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
