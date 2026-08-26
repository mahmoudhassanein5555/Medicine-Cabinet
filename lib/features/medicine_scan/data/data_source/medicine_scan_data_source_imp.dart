import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/constants/app_keys.dart';
import 'package:medicine_cabinet/core/errors/error.dart';
import 'package:medicine_cabinet/core/utils/cloudinary_service.dart';
import 'package:medicine_cabinet/features/medicine_scan/data/data_source/medicine_scan_data_source.dart';
import 'package:medicine_cabinet/features/medicine_scan/data/models/medicine_model.dart';
import 'package:medicine_cabinet/features/medicine_scan/data/models/medicine_scan_model.dart';
import 'package:medicine_cabinet/features/medicine_scan/data/models/member_model.dart';

@LazySingleton(as: MedicineScanDataSource)
class MedicineScanDataSourceImp implements MedicineScanDataSource {
  final FirebaseFirestore firebaseFirestore;
  final Dio dio;

  MedicineScanDataSourceImp({
    required this.firebaseFirestore,
    required this.dio,
  });

  @override
  Future<MedicineScanModel> analyzeMidicine(File image) async {
    try {
      debugPrint("Starting medicine analysis and upload...");
      final results = await Future.wait([
        CloudinaryService.uploadImage(image),
        _sendImageToGemini(image),
      ]);

      final imageUrl = results[0];
      final response = results[1] as String;
      debugPrint("Gemini analysis completed successfully.");

      String cleanResponse = response.replaceAll('```json\n', '');
      cleanResponse = cleanResponse.replaceAll('```json', '');
      cleanResponse = cleanResponse.replaceAll('```', '');
      cleanResponse = cleanResponse.trim();
      final json = jsonDecode(cleanResponse) as Map<String, dynamic>;

      final model = MedicineScanModel.fromJson(json);

      final data = MedicineScanModel(
        name: model.name,
        type: model.type,
        category: model.category,
        expiryDate: model.expiryDate,
        description: model.description,
        imageUrl: imageUrl,
      );
      debugPrint(
        "name: ${data.name} category: ${data.category} type: ${data.type} desc: ${data.description} date: ${data.expiryDate} image Url: ${data.imageUrl}",
      );
      return data;
    } on DioException catch (e) {
      debugPrint("Failed in analyzeMidicine DataSource");
      debugPrint("====== DIO ERROR DETAILS ======");
      debugPrint("FINAL URI: ${e.requestOptions.uri}");
      debugPrint("STATUS CODE: ${e.response?.statusCode}");
      debugPrint("ERROR DATA FROM GOOGLE: ${e.response?.data}");
      debugPrint("===============================");
      rethrow;
    }
  }

  @override
  Future<void> addMedicine(MedicineModel medicine, String houseId) async {
    await firebaseFirestore
        .collection("households")
        .doc(houseId)
        .collection("medicines")
        .add(medicine.toJson());
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
    final apiKey = AppKeys.geminiApiKey.trim();
    if (apiKey.isEmpty) {
      throw RemoteException(
        'Gemini API key is missing. Please set GEMINI_API_KEY in your .env file.',
      );
    }

    final imageBytes = await image.readAsBytes();
    final base64Image = base64Encode(imageBytes);

    const model = "gemini-3.6-flash";

    final url =
        'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent';

    try {
      final response = await dio.post(
        url,
        queryParameters: {'key': apiKey},
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          'contents': [
            {
              'parts': [
                {
                  'text': '''
Analyze this medicine image and return ONLY a raw JSON object. 
Do not include any Markdown formatting, code blocks (like ```json), or plain text. Just the JSON object itself.

The JSON must contain exactly these fields:
{
  "name": string or null,
  "category": string or null,
  "type": string or null,
  "expiryDate": string or null,
  "description": string or null
}
Rules:
- Extract clearly visible information for name, category, type, and expiryDate.
- For the 'description', use your knowledge to write a very brief summary (maximum 1 or 2 sentences) about what this medicine is used for.
- Do not guess or invent information for the fields extracted from the image.
- If a field cannot be identified from the image, return null.
- expiryDate must use YYYY-MM-DD format when possible.
- Do not add any extra fields.
''',
                },
                {
                  'inline_data': {
                    'mime_type': 'image/jpeg',
                    'data': base64Image,
                  },
                },
              ],
            },
          ],
          'generationConfig': {'response_mime_type': 'application/json'},
        },
      );
      final data = response.data;
      debugPrint(
        "Gemini raw response: ${data['candidates'][0]['content']['parts'][0]['text']}",
      );
      return data['candidates'][0]['content']['parts'][0]['text'];
    } on DioException catch (e) {
      debugPrint("====== DIO ERROR DETAILS ======");
      debugPrint("FINAL URI: ${e.requestOptions.uri}");
      debugPrint("STATUS CODE: ${e.response?.statusCode}");
      debugPrint("ERROR DATA FROM GOOGLE: ${e.response?.data}");
      debugPrint("===============================");
      rethrow;
    }
  }
}
