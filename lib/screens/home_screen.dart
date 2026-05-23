import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onLock;

  const HomeScreen({super.key, required this.onLock});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Security Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You are in the secure area!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onLock,
              icon: const Icon(Icons.lock),
              label: const Text('Lock App'),
            ),
          ],
        ),
      ),
    );
  }
}
