import 'package:get_it/get_it.dart';
import 'package:ai_trip_planner/features/trip/data/repositories/trip_repository_impl.dart';
import 'package:ai_trip_planner/features/trip/domain/repositories/trip_repository.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/plan_your_adventure_bloc.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/suggested_cities_bloc.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/trip_details_bloc.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/activity_plan_bloc.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/auth_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final sl = GetIt.instance;

void init() {
  // External
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // Register repositories
  sl.registerLazySingleton<TripRepository>(() => TripRepositoryImpl());

  // Register BLoCs
  sl.registerFactory(() => PlanYourAdventureBloc());
  sl.registerFactory(() => SuggestedCitiesBloc(tripRepository: sl()));
  sl.registerFactory(() => TripDetailsBloc());
  sl.registerFactory(() => ActivityPlanBloc(tripRepository: sl()));
  sl.registerFactory(() => AuthBloc(tripRepository: sl(), secureStorage: sl()));
}
