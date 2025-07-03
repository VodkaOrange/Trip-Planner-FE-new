import 'package:ai_trip_planner/core/theme/app_colors.dart';
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
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
    _emailController.addListener(_validateFields);
  }

  @override
  void dispose() {
    _usernameController.removeListener(_validateFields);
    _passwordController.removeListener(_validateFields);
    _emailController.removeListener(_validateFields);
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _validateFields() {
    final bool isEnabled;
    if (_isSigningUp) {
      isEnabled = _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _emailController.text.isNotEmpty;
    } else {
      isEnabled = _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    }
    if (isEnabled != _isButtonEnabled) {
      setState(() {
        _isButtonEnabled = isEnabled;
      });
    }
  }

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
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                });
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invalid credentials. Please try again.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is AuthLoading;

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
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 16), // Increased spacing
                  if (_isSigningUp)
                    Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          enabled: !isLoading,
                        ),
                        const SizedBox(height: 16), // Increased spacing
                      ],
                    ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    onPressed: (isLoading || !_isButtonEnabled)
                        ? null
                        : () {
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
                    child: isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.white,
                            ),
                          )
                        : Text(_isSigningUp ? 'Sign Up' : 'Sign In'),
                  ),
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            setState(() {
                              _isSigningUp = !_isSigningUp;
                              _validateFields();
                            });
                          },
                    child: Text(_isSigningUp
                        ? 'Already have an account? Sign In'
                        : "Don't have an account? Sign Up"),
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
