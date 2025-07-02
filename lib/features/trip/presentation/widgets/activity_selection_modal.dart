import 'package:ai_trip_planner/features/trip/data/models/activity_model.dart';
import 'package:ai_trip_planner/features/trip/presentation/widgets/hearthstone_card.dart';
import 'package:flutter/material.dart';

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
      // Ensure the dialog has a shape and is clipped
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        // Constrain the height to prevent it from becoming too large
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Choose an Activity',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const Divider(height: 1),
            // Use an Expanded ListView for the scrollable content
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final activity = activities[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: HearthstoneCard(
                      imageUrl: activity.image,
                      title: activity.name,
                      description: activity.description,
                      onTap: () => onActivitySelected(activity),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
