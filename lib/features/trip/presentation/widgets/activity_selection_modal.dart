import 'package:flutter/material.dart';
import 'package:ai_trip_planner/features/trip/data/models/activity_model.dart';
import 'package:ai_trip_planner/features/trip/presentation/widgets/hearthstone_card.dart';

class ActivitySelectionModal extends StatelessWidget {
  final List<ActivityModel> activities;
  final Function(ActivityModel) onActivitySelected;

  const ActivitySelectionModal({
    super.key,
    required this.activities,
    required this.onActivitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose an Activity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...activities.map((activity) {
              return Hero(
                tag: activity.image, // Unique tag for the Hero animation
                child: HearthstoneCard(
                  imageUrl: activity.image,
                  title: activity.name,
                  description: activity.description,
                  onTap: () => onActivitySelected(activity),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
