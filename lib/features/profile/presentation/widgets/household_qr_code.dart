import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      width: 250.r,
      height: 250.r,
      color: Colors.white,
      padding: EdgeInsets.all(10.r),
      child: QrImageView(
        data: householdId,
        version: QrVersions.auto,
        size: 230.r,
        backgroundColor: Colors.white,
      ),
    );
  }
}