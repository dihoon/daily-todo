import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;
  final Widget? floatingButton;

  const DefaultLayout({
    super.key,
    required this.body,
    this.floatingButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: floatingButton,
      backgroundColor: Colors.white,
      body: body,
    );
  }
}
