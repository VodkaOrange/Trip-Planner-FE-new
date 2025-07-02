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
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<TripDetailsBloc, TripDetailsState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTravelerSelection(context, state),
                  const SizedBox(height: 24),
                  _buildDateSelection(context, state),
                  const SizedBox(height: 24),
                  _buildOriginAirport(context, state),
                  const Spacer(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(width: 8),
            const Text(
              'Travelers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Adults'),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => context
                      .read<TripDetailsBloc>()
                      .add(DecrementAdults()),
                ),
                Text(state.numberOfAdults.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => context
                      .read<TripDetailsBloc>()
                      .add(IncrementAdults()),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Children'),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => context
                      .read<TripDetailsBloc>()
                      .add(DecrementChildren()),
                ),
                Text(state.numberOfChildren.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => context
                      .read<TripDetailsBloc>()
                      .add(IncrementChildren()),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateSelection(
      BuildContext context, TripDetailsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.calendar_today),
            const SizedBox(width: 8),
            const Text(
              'Trip dates',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: state.dateRange == null
                ? 'Trip dates range'
                : '${DateFormat.yMd().format(state.dateRange!.start)} - ${DateFormat.yMd().format(state.dateRange!.end)}',
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
    );
  }

  Widget _buildOriginAirport(
      BuildContext context, TripDetailsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Origin Airport (optional)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Origin Airport (optional)',
          ),
          onChanged: (value) =>
              context.read<TripDetailsBloc>().add(SetOriginAirport(value)),
        ),
      ],
    );
  }

  Widget _buildNextButton(
      BuildContext context, TripDetailsState state) {
    return Center(
      child: ElevatedButton(
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
        child: const Text('Next'),
      ),
    );
  }
}
