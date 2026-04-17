import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Profile'),
              onPressed: () => context.go('/profile'),
            ),
            ElevatedButton(
              child: Text('Profile=>Library'),
              onPressed: () => context.push('/profile/library'),
            ),
            ElevatedButton(
              child: Text('Profile=>Library=>Contact'),
              onPressed: () => context.go('/profile/library/contact'),
            ),
          ],
        ),
      ),
    );
  }
}
