import 'package:ai_trip_planner/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

class SaveShareBookScreen extends StatefulWidget {
  const SaveShareBookScreen({super.key});

  @override
  State<SaveShareBookScreen> createState() => _SaveShareBookScreenState();
}

class _SaveShareBookScreenState extends State<SaveShareBookScreen> {
  bool _consentChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Trip Saved!'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Lottie.asset(
              'assets/animations/trip_saved.json',
              height: 250,
              repeat: true,
              reverse: true,
            ),
            const SizedBox(height: 32),
            Text(
              'Your trip plan has been saved to your profile.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 48),
            TextButton.icon(
              onPressed: () {
                Share.share('Check out my awesome trip plan!');
              },
              icon: const Icon(Icons.share_outlined),
              label: const Text('Share trip plan with friends'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _consentChecked
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Offer requested! Check your email.'),
                        ),
                      );
                    }
                  : null,
              child: const Text('Request an offer via email'),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: _consentChecked,
                  onChanged: (value) {
                    setState(() {
                      _consentChecked = value!;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'I consent to the processing of my personal data for the purpose of scheduling an appointment and preparing an offer. I can revoke my consent at any time with effect for the future by contacting marketing@dertour-reisebuero.de.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
