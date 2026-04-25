import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_drive_with_flutter/router/config/routes_name.dart';

class ContactScreen extends StatelessWidget {
  final String? params;

  const ContactScreen({super.key, this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(params ?? 'No params provided'),
            ElevatedButton(
              onPressed: () => context.go(RoutesName.home),
              child: const Text('Go To Home'),
            ),
          ],
        ),
      ),
    );
  }
}
