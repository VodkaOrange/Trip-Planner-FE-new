import 'package:ai_trip_planner/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
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
      appBar: const CustomAppBar(title: 'Save, Share & Book'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your trip is ready!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextButton.icon(
              onPressed: () {
                Share.share('Check out my awesome trip plan!');
              },
              icon: const Icon(Icons.share),
              label: const Text('Share trip plan with friends'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
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
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
