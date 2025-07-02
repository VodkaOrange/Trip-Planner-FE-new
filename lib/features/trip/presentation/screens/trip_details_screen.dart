import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/trip_details_bloc.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/trip_details_event.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/trip_details_state.dart';
import 'package:ai_trip_planner/features/trip/presentation/screens/activity_plan_screen.dart';
import 'package:ai_trip_planner/injection_container.dart';
import 'package:intl/intl.dart';

class TripDetailsScreen extends StatelessWidget {
  final String destination;
  final List<String> selectedActivities;

  const TripDetailsScreen({
    super.key,
    required this.destination,
    required this.selectedActivities,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TripDetailsBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trip Details'),
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<TripDetailsBloc, TripDetailsState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Great! Let's sort out the details.",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 24),
                          _buildTravelerSelection(context, state),
                          const SizedBox(height: 24),
                          _buildDateSelection(context, state),
                          const SizedBox(height: 24),
                          _buildOriginAirport(context, state),
                        ],
                      ),
                    ),
                  ),
                  _buildNextButton(context, state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTravelerSelection(
      BuildContext context, TripDetailsState state) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.group_outlined),
                const SizedBox(width: 8),
                Text(
                  'Who is traveling?',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
            _buildCounterTile(
              context: context,
              title: 'Adults',
              value: state.numberOfAdults,
              onIncrement: () =>
                  context.read<TripDetailsBloc>().add(IncrementAdults()),
              onDecrement: () =>
                  context.read<TripDetailsBloc>().add(DecrementAdults()),
            ),
            _buildCounterTile(
              context: context,
              title: 'Children',
              value: state.numberOfChildren,
              onIncrement: () =>
                  context.read<TripDetailsBloc>().add(IncrementChildren()),
              onDecrement: () =>
                  context.read<TripDetailsBloc>().add(DecrementChildren()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterTile({
    required BuildContext context,
    required String title,
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: onDecrement,
            color: Theme.of(context).primaryColor,
          ),
          Text(value.toString(),
              style:
                  Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: onIncrement,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelection(
      BuildContext context, TripDetailsState state) {
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                     const Icon(Icons.calendar_month_outlined),
                     const SizedBox(width: 8),
                     Text('When are you going?',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Select your trip dates',
                    prefixIcon: const Icon(Icons.calendar_today_outlined),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  controller: TextEditingController(
                    text: state.dateRange == null
                        ? ''
                        : '${DateFormat.yMMMd().format(state.dateRange!.start)} - ${DateFormat.yMMMd().format(state.dateRange!.end)}',
                  ),
                  onTap: () async {
                    final dateRange = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (dateRange != null) {
                      context
                          .read<TripDetailsBloc>()
                          .add(SelectDateRange(dateRange));
                    }
                  },
                ),
              ],
            )));
  }

  Widget _buildOriginAirport(
      BuildContext context, TripDetailsState state) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.flight_takeoff_outlined),
                const SizedBox(width: 8),
                Text('Where are you flying from?',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
             const SizedBox(height: 8),
            const Divider(),
             const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Origin Airport (optional)',
                prefixIcon: const Icon(Icons.airplanemode_active_outlined),
                border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                 filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) =>
                  context.read<TripDetailsBloc>().add(SetOriginAirport(value)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(
      BuildContext context, TripDetailsState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: state.dateRange != null
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ActivityPlanScreen(
                      destination: destination,
                      departureCity: state.originAirport,
                      numberOfChildren: state.numberOfChildren,
                      numberOfAdults: state.numberOfAdults,
                      fromDate: DateFormat('yyyy-MM-dd')
                          .format(state.dateRange!.start),
                      toDate: DateFormat('yyyy-MM-dd')
                          .format(state.dateRange!.end),
                      interests: selectedActivities,
                    ),
                  ),
                );
              }
            : null,
        child: const Text('Next', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
