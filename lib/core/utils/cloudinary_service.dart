import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CloudinaryService {
  static const String _cloudName = 'c95zapgj';
  static const String _uploadPreset = 'medicine_preset';

  static Future<String?> uploadImage(File imageFile) async {
    try {
      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/$_cloudName/image/upload',
      );

      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = _uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['secure_url'] as String?;
      } else {
        _log('Cloudinary Upload Failed: ${response.body}');
        return null;
      }
    } catch (e) {
      _log('Error uploading to Cloudinary: $e');
      return null;
    }
  }

  static void _log(String message) {
    if (kDebugMode) {
      log(message, name: 'CloudinaryService');
    }
  }
}
