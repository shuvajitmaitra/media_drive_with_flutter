import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ContactScreen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('ContactScreen'),
              onPressed: () => GoRouter.of(context).go('/'),
            ),
          ],
        ),
      ),
    );
  }
}
