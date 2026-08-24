import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class CacheHelper {
  final SharedPreferences _sharedPreferences;

  CacheHelper(this._sharedPreferences);

  Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await _sharedPreferences.setString(key, value);
    }

    if (value is int) {
      return await _sharedPreferences.setInt(key, value);
    }

    if (value is bool) {
      return await _sharedPreferences.setBool(key, value);
    }

    if (value is double) {
      return await _sharedPreferences.setDouble(key, value);
    }

    return false;
  }

  dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  Future<bool> clearAllData() async {
    return await _sharedPreferences.clear();
  }
}

@module
abstract class AppModule {
  @preResolve
  Future<SharedPreferences> get sharedPrefs => SharedPreferences.getInstance();

  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @lazySingleton
  Dio get dio => Dio();
}