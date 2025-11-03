import 'package:devfest_bari_2025/data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  AuthenticationRepository._internal();

  static final AuthenticationRepository _instance =
      AuthenticationRepository._internal();

  factory AuthenticationRepository() => _instance;

  final AuthenticationApi _authApi = AuthenticationApi();

  Future<UserProfile> getInitialAuthState() async {
    final firebaseUser = await _authApi.getInitialAuthState();
    if (firebaseUser != null) {
      return await getUserProfile(firebaseUser);
    } else {
      return const UserProfile();
    }
  }

  Future<UserProfile> getUserProfile(User user) async {
    final response = await _authApi.getUserProfile(user);

    if (response.error.code.isNotEmpty) {
      signOut();
      switch (response.error.code) {
        case 'user-not-found':
          throw UserNotFoundError();
        default:
          throw UnknownAuthenticationError();
      }
    }

    return UserProfile.fromJson(response.data);
  }

  Future<void> signUp({
    required String nickname,
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    final response = await _authApi.signUp(
      nickname: nickname,
      name: name,
      surname: surname,
      email: email,
      password: password,
    );

    if (response.error.code.isNotEmpty) {
      switch (response.error.code) {
        case 'user-already-registered':
          throw UserAlreadyRegisteredError();
        default:
          throw UnknownAuthenticationError();
      }
    }
  }

  Future<Group> checkIn(String authorizationCode) async {
    final response = await _authApi.checkIn(authorizationCode);

    if (response.error.code.isNotEmpty) {
      switch (response.error.code) {
        case 'code-not-found':
          throw CheckInCodeNotFoundError();
        case 'code-expired':
          throw CheckInCodeExpiredError();
        default:
          throw UnknownAuthenticationError();
      }
    }

    return Group.fromJson(response.data);
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
          ? await getUserProfile(userCredential.user!)
          : const UserProfile();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw UserNotFoundError();
        case 'invalid-credential':
        case 'invalid-email':
        case 'invalid-password':
        case 'wrong-password':
          throw InvalidCredentialsError();
        default:
          throw UnknownAuthenticationError();
      }
    } on Exception {
      rethrow;
    }
  }

  Future<void> signOut() async => await _authApi.signOut();
}
