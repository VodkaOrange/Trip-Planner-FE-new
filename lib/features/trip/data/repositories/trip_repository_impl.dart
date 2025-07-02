import 'package:ai_trip_planner/core/constants/app_constants.dart';
import 'package:ai_trip_planner/core/network/logging_interceptor.dart';
import 'package:ai_trip_planner/features/trip/data/models/itinerary_response_model.dart';
import 'package:ai_trip_planner/features/trip/data/models/suggested_city_model.dart';
import 'package:ai_trip_planner/features/trip/data/models/activity_model.dart';
import 'package:ai_trip_planner/features/trip/domain/repositories/trip_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TripRepositoryImpl implements TripRepository {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  TripRepositoryImpl({required this.dio, required this.secureStorage}) {
    dio.options.baseUrl = AppConstants.baseUrl;
    dio.interceptors.addAll([
      LoggingInterceptor(),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await secureStorage.read(key: 'token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    ]);
  }

  @override
  Future<List<SuggestedCityModel>> getSuggestedCities(
      List<String> preferences) async {
    final response = await dio.post(
      '/trip/suggestions/cities',
      data: {'preferences': preferences},
    );
    return (response.data as List)
        .map((city) => SuggestedCityModel.fromJson(city))
        .toList();
  }

  @override
  Future<ItineraryResponseModel> startTrip(
      String destination,
      String? departureCity,
      int numberOfChildren,
      int numberOfAdults,
      String fromDate,
      String toDate,
      List<String> interests) async {
    final response = await dio.post(
      '/trip/start',
      data: {
        'destination': destination,
        'departureCity': departureCity,
        'numberOfChildren': numberOfChildren,
        'numberOfAdults': numberOfAdults,
        'fromDate': fromDate,
        'toDate': toDate,
        'interests': interests,
      },
    );
    return ItineraryResponseModel.fromJson(response.data);
  }

  @override
  Future<List<ActivityModel>> getSuggestedActivities(
      int tripId, int dayId) async {
    final response =
        await dio.get('/trip/$tripId/days/$dayId/suggestions/activities');
    return (response.data as List)
        .map((activity) => ActivityModel.fromJson(activity))
        .toList();
  }

  @override
  Future<ItineraryResponseModel> selectActivity(
      int tripId, int dayId, ActivityModel activity) async {
    final response = await dio.post(
      '/trip/$tripId/days/$dayId/activities',
      data: activity.toJson(),
    );
    return ItineraryResponseModel.fromJson(response.data);
  }

  @override
  Future<String> signIn(String username, String password) async {
    final response = await dio.post(
      '/auth/signin',
      data: {'username': username, 'password': password},
    );
    return response.data['token'];
  }

  @override
  Future<String> signUp(String username, String email, String password) async {
    final response = await dio.post(
      '/auth/signup',
      data: {'username': username, 'email': email, 'password': password},
    );
    return response.data;
  }
}
