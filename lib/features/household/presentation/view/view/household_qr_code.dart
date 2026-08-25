import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HouseholdQrCode extends StatelessWidget {
  final String householdId;

  const HouseholdQrCode({
    super.key,
    required this.householdId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: QrImageView(
        data: householdId,
        version: QrVersions.auto,
        size: 230,
        backgroundColor: Colors.white,
      ),
    );
  }
}