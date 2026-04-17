import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.pop(),
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}
