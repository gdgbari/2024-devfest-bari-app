import 'package:devfest_bari_2024/data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  AuthenticationRepository._internal();

  static final AuthenticationRepository _instance =
      AuthenticationRepository._internal();

  factory AuthenticationRepository() => _instance;

  final AuthenticationApi _authApi = AuthenticationApi();

  Future<UserProfile> getInitialAuthState() async {
    final firebaseUser = await _authApi.getInitialAuthState();
    if (firebaseUser == null) {
      return const UserProfile();
    } else {
      return await getUserData(firebaseUser);
    }
  }

  Future<UserProfile> getUserData(User user) async {
    final userData = Map<String, dynamic>.from(
      await _authApi.getUserData(user),
    );
    return UserProfile.fromMap(userData);
  }

  Future<UserProfile> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _authApi.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user != null
          ? await getUserData(userCredential.user!)
          : const UserProfile();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async => await _authApi.signOut();
}
