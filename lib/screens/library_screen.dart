import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LibraryScreen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Go To Home'),
              onPressed: () => context.go('/'),
            ),
            ElevatedButton(
              child: Text('Go Back'),
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
