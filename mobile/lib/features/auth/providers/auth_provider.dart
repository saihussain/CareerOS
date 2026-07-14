import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/login_request.dart';
import '../repositories/auth_repository.dart';
import '../../../core/storage/secure_storage.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<void>>((ref) {
  return AuthNotifier(
    ref.read(authRepositoryProvider),
  );
});

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  AuthNotifier(this._repository)
      : super(const AsyncData(null));

  final AuthRepository _repository;

  final SecureStorage _storage = SecureStorage();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    try {
      final response = await _repository.login(
        LoginRequest(
          email: email,
          password: password,
        ),
      );

      await _storage.saveToken(response.token);

      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}