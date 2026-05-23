import 'package:flutter/material.dart';
import 'services/biometric_auth_service.dart';
import 'screens/lock_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SecurityApp());
}

class SecurityApp extends StatefulWidget {
  const SecurityApp({super.key});

  @override
  State<SecurityApp> createState() => _SecurityAppState();
}

class _SecurityAppState extends State<SecurityApp> with WidgetsBindingObserver {
  final BiometricAuthService _authService = BiometricAuthService();
  bool _isLocked = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _lock();
    }
  }

  Future<void> _attemptUnlock() async {
    setState(() => _errorMessage = null);
    final success = await _authService.authenticate();
    if (!mounted) return;
    setState(() {
      if (success) {
        _isLocked = false;
      } else {
        _errorMessage =
            _authService.lastErrorMessage ?? 'Authentication failed';
      }
    });
  }

  void _lock() {
    setState(() {
      _isLocked = true;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Security',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _isLocked
          ? LockScreen(
              errorMessage: _errorMessage,
              onUnlock: _attemptUnlock,
            )
          : HomeScreen(onLock: _lock),
    );
  }
}
