import 'dart:io';

import 'package:medicine_cabinet/features/medicine_scan/data/models/medicine_model.dart';
import 'package:medicine_cabinet/features/medicine_scan/data/models/medicine_scan_model.dart';
import 'package:medicine_cabinet/features/medicine_scan/data/models/member_model.dart';

abstract class MedicineScanDataSource {
  Future<MedicineScanModel> analyzeMidicine(File image);
  Future<void> addMedicine(MedicineModel medicine, String houseId);
  Future<List<MemberModel>> getHouseholdMembers(String houseHoldId);
}
