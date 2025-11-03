import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/logic.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final _authRepo = AuthenticationRepository();

  AuthenticationCubit() : super(const AuthenticationState()) {
    _getInitialAuthState();
  }

  Future<void> _getInitialAuthState() async {
    final user = await _authRepo.getInitialAuthState();
    if (user.userId.isNotEmpty) {
      if (user.group.groupId.isEmpty) {
        emit(
          state.copyWith(
            userProfile: user,
            status: AuthenticationStatus.checkInRequired,
            isAuthenticated: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            userProfile: user,
            status: AuthenticationStatus.authenticationSuccess,
            isAuthenticated: true,
          ),
        );
      }
    } else {
      emit(state.copyWith(status: AuthenticationStatus.initialAuthFailure));
    }
  }

  Future<void> signUp({
    required String nickname,
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        userProfile: const UserProfile(),
        status: AuthenticationStatus.signUpInProgress,
        isAuthenticated: false,
        error: AuthenticationError.none,
      ),
    );

    try {
      _checkSignUpEmptyData(nickname, name, surname, email, password);

      InputValidators.checkEmail(email);
      InputValidators.checkPassword(password);

      await _authRepo.signUp(
        nickname: nickname,
        name: name,
        surname: surname,
        email: email,
        password: password,
      );

      emit(state.copyWith(status: AuthenticationStatus.signUpSuccess));
      signInWithEmailAndPassword(email: email, password: password);
    } on UserAlreadyRegisteredError {
      emit(
        state.copyWith(
          status: AuthenticationStatus.signUpFailure,
          error: AuthenticationError.userAlreadyRegistered,
        ),
      );
    } on InvalidDataError {
      emit(
        state.copyWith(
          status: AuthenticationStatus.signUpFailure,
          error: AuthenticationError.invalidCredentials,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: AuthenticationStatus.signUpFailure,
          error: AuthenticationError.unknown,
        ),
      );
    }
  }

  void _checkSignUpEmptyData(
    String nickname,
    String name,
    String surname,
    String email,
    String password,
  ) {
    final check = nickname.isNotEmpty &&
        name.isNotEmpty &&
        surname.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty;

    if (!check) throw InvalidDataError();
  }

  Future<void> checkIn(String authorizationCode) async {
    emit(state.copyWith(status: AuthenticationStatus.checkInInProgress));

    try {
      final group = await _authRepo.checkIn(authorizationCode);

      emit(
        state.copyWith(
          userProfile: state.userProfile.copyWith(
            group: group,
          ),
          status: AuthenticationStatus.checkInSuccess,
        ),
      );
    } on CheckInCodeNotFoundError {
      emit(
        state.copyWith(
          status: AuthenticationStatus.checkInFailure,
          error: AuthenticationError.checkInCodeNotFound,
        ),
      );
    } on CheckInCodeExpiredError {
      emit(
        state.copyWith(
          status: AuthenticationStatus.checkInFailure,
          error: AuthenticationError.checkInCodeExpired,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: AuthenticationStatus.checkInFailure,
          error: AuthenticationError.unknown,
        ),
      );
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        userProfile: const UserProfile(),
        status: AuthenticationStatus.authenticationInProgress,
        isAuthenticated: false,
        error: AuthenticationError.none,
      ),
    );

    try {
      _checkSignInEmptyData(email, password);

      InputValidators.checkEmail(email);
      InputValidators.checkPassword(password);

      final userProfile = await _authRepo.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userProfile.group.groupId.isEmpty) {
        emit(
          state.copyWith(
            userProfile: userProfile,
            status: AuthenticationStatus.checkInRequired,
            isAuthenticated: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            userProfile: userProfile,
            status: AuthenticationStatus.authenticationSuccess,
            isAuthenticated: true,
          ),
        );
      }
    } on UserNotFoundError {
      emit(
        state.copyWith(
          status: AuthenticationStatus.authenticationFailure,
          error: AuthenticationError.userNotFound,
        ),
      );
    } on InvalidDataError {
      emit(
        state.copyWith(
          status: AuthenticationStatus.authenticationFailure,
          error: AuthenticationError.invalidCredentials,
        ),
      );
    } on InvalidCredentialsError {
      emit(
        state.copyWith(
          status: AuthenticationStatus.authenticationFailure,
          error: AuthenticationError.invalidCredentials,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: AuthenticationStatus.authenticationFailure,
          error: AuthenticationError.unknown,
        ),
      );
    }
  }

  void _checkSignInEmptyData(
    String email,
    String password,
  ) {
    final check = email.isNotEmpty && password.isNotEmpty;

    if (!check) throw InvalidDataError();
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: AuthenticationStatus.signOutInProgress));
    await _authRepo.signOut();
    emit(
      state.copyWith(
        userProfile: const UserProfile(),
        status: AuthenticationStatus.signOutSuccess,
        isAuthenticated: false,
      ),
    );
  }
}
