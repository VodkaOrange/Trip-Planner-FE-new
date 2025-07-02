import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/auth_bloc.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/auth_event.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/auth_state.dart';
import 'package:ai_trip_planner/injection_container.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({super.key});

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Success! You are now logged in.'),
                    backgroundColor: Colors.green,
                  ),
                );
                // Add a small delay so the user can see the snackbar
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                });
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isSigningUp ? 'Sign Up' : 'Sign In',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  if (_isSigningUp)
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_isSigningUp) {
                        context.read<AuthBloc>().add(SignUp(
                              _usernameController.text,
                              _emailController.text,
                              _passwordController.text,
                            ));
                      } else {
                        context.read<AuthBloc>().add(SignIn(
                              _usernameController.text,
                              _passwordController.text,
                            ));
                      }
                    },
                    child: Text(_isSigningUp ? 'Sign Up' : 'Sign In'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isSigningUp = !_isSigningUp;
                      });
                    },
                    child: Text(_isSigningUp
                        ? 'Already have an account? Sign In'
                        : 'Dont have an account? Sign Up'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
