import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_cabinet/features/auth/data/datasources/auth_remote_datasource.dart';

class AuthRemoteDatasourceImp implements AuthRemoteDataSource{
  final FirebaseAuth firebaseAuth;
  AuthRemoteDatasourceImp(this.firebaseAuth);

  @override
  Future<void> forgotPassword({required String email})async {
    await firebaseAuth.sendPasswordResetEmail(email: email);

  }

  @override
  Future<User> login({required String email, required String password}) async{

    final credential= await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user!;
  }

  @override
  Future<void> logout()async {
   await firebaseAuth.signOut();
  }

  @override
  Future<User> register({required String name, required String email, required String password}) async{
    final credential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await credential.user!.updateDisplayName(name);

    return credential.user!;
  }

  @override
  Future<User> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
  
}