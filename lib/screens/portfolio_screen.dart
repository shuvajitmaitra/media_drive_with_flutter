import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PortfolioScreen"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('PortfolioScreen'),
          onPressed: () => GoRouter.of(context).go('/contact'),
        ),
      ),
    );
  }
}
