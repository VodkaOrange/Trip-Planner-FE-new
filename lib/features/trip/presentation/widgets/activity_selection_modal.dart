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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        // Set a height that accommodates the cards and title
        height: 500,
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
                scrollDirection: Axis.horizontal, // Changed to horizontal
                padding: const EdgeInsets.all(16.0),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final activity = activities[index];
                  return Padding(
                    // Changed to horizontal padding
                    padding: const EdgeInsets.only(right: 16.0),
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
