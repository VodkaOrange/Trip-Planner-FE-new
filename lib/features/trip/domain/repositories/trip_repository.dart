import 'package:ai_trip_planner/features/trip/data/models/itinerary_response_model.dart';
import 'package:ai_trip_planner/features/trip/data/models/suggested_city_model.dart';
import 'package:ai_trip_planner/features/trip/data/models/activity_model.dart';

abstract class TripRepository {
  Future<List<SuggestedCityModel>> getSuggestedCities(List<String> preferences);

  Future<ItineraryResponseModel> startTrip(
      String destination,
      String? departureCity,
      int numberOfChildren,
      int numberOfAdults,
      String fromDate,
      String toDate,
      List<String> interests);

  Future<List<ActivityModel>> getSuggestedActivities(int tripId, int dayId);

  Future<ItineraryResponseModel> selectActivity(
      int tripId, int dayId, ActivityModel activity);

  Future<String> signIn(String username, String password);

  Future<String> signUp(String username, String email, String password);
}
