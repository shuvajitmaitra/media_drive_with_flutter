import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_drive_with_flutter/routes/routes.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.push(AppRoutePaths.media),
              child: const Text('Open Media'),
            ),
            ElevatedButton(
              onPressed: () => context.go(AppRoutePaths.home),
              child: const Text('Go To Home'),
            ),
          ],
        ),
      ),
    );
  }
}
