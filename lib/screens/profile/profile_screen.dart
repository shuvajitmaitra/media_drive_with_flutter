import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_drive_with_flutter/router/config/routes_name.dart';

class ProfileScreen extends StatelessWidget {
  final String? name;

  const ProfileScreen({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    final title = name == null ? 'Profile Screen' : 'Profile Screen $name';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.push(RoutesName.contact),
              child: const Text('Open Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
