import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HouseholdQrScreen extends StatelessWidget {
  final String householdId;

  const HouseholdQrScreen({
    super.key,
    required this.householdId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Household QR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: householdId,
              version: QrVersions.auto,
              size: 280,
            ),

            const SizedBox(height: 24),

            Text(
              'Scan this QR code to join my household',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            Text(
              householdId,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}