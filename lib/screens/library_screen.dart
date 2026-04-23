import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_drive_with_flutter/routes/routes.dart';

class LibraryScreen extends StatelessWidget {
  final String? test;
  const LibraryScreen({super.key, this.test});

  @override
  Widget build(BuildContext context) {
    final libraryParam = test ?? 'default';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Library Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Library param: $libraryParam'),
            ElevatedButton(
              onPressed: () => context.push(AppRoutePaths.contact(libraryParam)),
              child: const Text('Open Contact'),
            ),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
