import 'package:ai_trip_planner/core/theme/app_colors.dart';
import 'package:ai_trip_planner/features/trip/data/models/activity_model.dart';
import 'package:flutter/material.dart';

class ActivityDetailsScreen extends StatelessWidget {
  final ActivityModel activity;

  const ActivityDetailsScreen({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                activity.name,
                style: const TextStyle(
                  color: AppColors.white,
                  shadows: [Shadow(blurRadius: 10)],
                ),
              ),
              background: Hero(
                tag: activity.image ?? 'activity-hero-${activity.id}',
                child: activity.image != null
                    ? Image.network(
                        activity.image!,
                        fit: BoxFit.cover,
                        color: AppColors.black.withOpacity(0.3),
                        colorBlendMode: BlendMode.darken,
                        errorBuilder: (context, error, stackTrace) {
                          // Show the placeholder on error
                          return _buildImagePlaceholder(context);
                        },
                      )
                    : _buildImagePlaceholder(context),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailItem(
                        context,
                        icon: Icons.description_outlined,
                        title: 'Description',
                        content: activity.description,
                      ),
                      _buildDetailItem(
                        context,
                        icon: Icons.location_city_outlined,
                        title: 'City',
                        content: activity.city,
                      ),
                      if (activity.address != null)
                        _buildDetailItem(
                          context,
                          icon: Icons.location_on_outlined,
                          title: 'Address',
                          content: activity.address!,
                        ),
                      _buildDetailItem(
                        context,
                        icon: Icons.timer_outlined,
                        title: 'Expected Duration',
                        content: '${activity.expectedDurationHours} hours',
                      ),
                      _buildDetailItem(
                        context,
                        icon: Icons.euro_symbol_outlined,
                        title: 'Estimated Cost',
                        content: '€${activity.estimatedCostEUR} per person',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.7),
            Theme.of(context).primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Icon(
        Icons.local_activity_outlined,
        size: 100,
        color: AppColors.white,
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context,
      {required IconData icon,
      required String title,
      required String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
