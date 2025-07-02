import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback onTryAgain;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final Color buttonTextColor;
  final Color buttonBackgroundColor;

  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.onTryAgain,
    this.icon = Icons.error_outline,
    this.iconColor = Colors.redAccent,
    this.textColor = Colors.black87,
    this.buttonTextColor = Colors.white,
    this.buttonBackgroundColor = Colors.redAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 64),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor, fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              onPressed: onTryAgain,
              style: ElevatedButton.styleFrom(
                foregroundColor: buttonTextColor,
                backgroundColor: buttonBackgroundColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
