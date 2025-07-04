import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_trip_planner/features/trip/domain/repositories/trip_repository.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/auth_event.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TripRepository tripRepository;
  final FlutterSecureStorage secureStorage;

  AuthBloc({required this.tripRepository, required this.secureStorage})
      : super(AuthInitial()) {
    on<SignIn>(_onSignIn);
    on<SignUp>(_onSignUp);
  }

  void _onSignIn(SignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await tripRepository.signIn(event.username, event.password);
      await secureStorage.write(key: 'token', value: token);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Sign up the user and get the token directly
      final token = await tripRepository.signUp(
          event.username, event.email, event.password);
      await secureStorage.write(key: 'token', value: token);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
