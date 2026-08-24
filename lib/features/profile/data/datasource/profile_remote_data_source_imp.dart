import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'package:medicine_cabinet/features/profile/data/datasource/profile_remote_data_source.dart';
import '../models/profile_model.dart';

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl
    implements ProfileRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  const ProfileRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<ProfileModel> getProfile() async {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('profileUserNotAuthenticated');
    }

    try {
      final doc = await firestore
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists && doc.data() != null) {
        return ProfileModel.fromMap({
          'id': user.uid,
          ...doc.data()!,
        });
      }

      return ProfileModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        photoUrl: user.photoURL,
      );
    } on FirebaseException catch (e) {
      throw Exception(_mapFirebaseError(e));
    } catch (_) {
      throw Exception('profileLoadFailed');
    }
  }

  @override
  Future<ProfileModel> updateProfile({
    required String name,
    String? photoUrl,
  }) async {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('profileUserNotAuthenticated');
    }

    try {
      await user.updateDisplayName(name);

      if (photoUrl != null) {
        await user.updatePhotoURL(photoUrl);
      }

      await firestore.collection('users').doc(user.uid).set(
        {
          'name': name,
          'email': user.email,
          'photoUrl': photoUrl ?? user.photoURL,
        },
        SetOptions(merge: true),
      );

      await user.reload();

      final updatedUser = firebaseAuth.currentUser!;

      return ProfileModel(
        id: updatedUser.uid,
        name: updatedUser.displayName ?? '',
        email: updatedUser.email ?? '',
        photoUrl: updatedUser.photoURL,
      );
    } on FirebaseException catch (e) {
      throw Exception(_mapFirebaseError(e));
    } catch (_) {
      throw Exception('profileUpdateFailed');
    }
  }

  String _mapFirebaseError(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return 'profilePermissionDenied';

      case 'not-found':
        return 'profileNotFound';

      case 'unavailable':
        return 'profileNetworkError';

      case 'failed-precondition':
        return 'profileOperationFailed';

      default:
        return 'profileServerError';
    }
  }
}