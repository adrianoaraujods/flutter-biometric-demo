import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class BiometricAuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  String? _lastError;

  String? get lastErrorMessage => _lastError;

  Future<bool> authenticate() async {
    try {
      final result = await _localAuth.authenticate(
        localizedReason: 'Unlock the app to access your content',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: false,
        ),
      );
      _lastError = null;
      return result;
    } on PlatformException catch (e) {
      _lastError = e.message ?? 'Authentication error';
      return false;
    }
  }
}
