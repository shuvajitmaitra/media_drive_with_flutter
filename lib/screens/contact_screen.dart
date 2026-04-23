import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_drive_with_flutter/routes/routes.dart';

class ContactScreen extends StatelessWidget {
  final String? params;
  const ContactScreen({super.key, this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ContactScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(params!),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go(AppRoutePaths.home),
              child: const Text('Go To Home'),
            ),
          ],
        ),
      ),
    );
  }
}
