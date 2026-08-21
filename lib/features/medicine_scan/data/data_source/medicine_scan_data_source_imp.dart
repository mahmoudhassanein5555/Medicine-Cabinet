import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:medicine_cabinet/core/constants/app_keys.dart';
import 'package:medicine_cabinet/core/utils/cloudinary_service.dart';
import 'package:medicine_cabinet/features/medicine_scan/data/data_source/medicine_scan_data_source.dart';
import 'package:medicine_cabinet/features/medicine_scan/data/models/medicine_model.dart';
import 'package:medicine_cabinet/features/medicine_scan/data/models/medicine_scan_model.dart';
import 'package:medicine_cabinet/features/medicine_scan/data/models/member_model.dart';

class MedicineScanDataSourceImp implements MedicineScanDataSource {
  final FirebaseFirestore firebaseFirestore;
  final Dio dio;

  MedicineScanDataSourceImp({
    required this.firebaseFirestore,
    required this.dio,
  });

  @override
  Future<MedicineScanModel> analyzeMidicine(File image) async {
    final imageUrl = CloudinaryService.uploadImage(image);
    final response = await _sendImageToGemini(image);
    final json = jsonDecode(response);

    final model = MedicineScanModel.fromJson(json);
    return MedicineScanModel(
      name: model.name,
      type: model.type,
      category: model.category,
      expiryDate: model.expiryDate,
      imageUrl: imageUrl,
    );
  }

  @override
  Future<void> addMedicine(MedicineModel medicine) async {
    await firebaseFirestore.collection("medicines").add(medicine.toJson());
  }

  @override
  Future<List<MemberModel>> getHouseholdMembers(String houseHoldId) async {
    final jsonResult = await firebaseFirestore
        .collection("households")
        .doc(houseHoldId)
        .collection("members")
        .get();
    final List<MemberModel> members = jsonResult.docs
        .map((elemnt) => MemberModel.fromFirestore(elemnt))
        .toList();

    return members;
  }

  Future<String> _sendImageToGemini(File image) async {
    final imageBytes = await image.readAsBytes();
    final base64Image = base64Encode(imageBytes);

    final apiKey = AppKeys.geminiApiKey;

    const model = 'gemini-2.5-flash';

    final url =
        'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent';

    final response = await dio.post(
      url,
      queryParameters: {'key': apiKey},
      data: {
        'contents': [
          {
            'parts': [
              {
                'text': '''
Analyze this medicine image and return ONLY valid JSON.

The JSON must contain exactly these fields:
{
  "name": string or null,
  "category": string or null,
  "type": string or null,
  "expiryDate": string or null
}

Rules:
- Extract only information that is clearly visible.
- Do not guess or invent information.
- If a field cannot be identified, return null.
- expiryDate must use YYYY-MM-DD format when possible.
- Do not add any extra fields.
''',
              },
              {
                'inline_data': {'mime_type': 'image/jpeg', 'data': base64Image},
              },
            ],
          },
        ],
      },
    );
    final data = response.data;

    return data['candidates'][0]['content']['parts'][0]['text'];
  }
}
