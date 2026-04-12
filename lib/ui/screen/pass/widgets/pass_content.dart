import 'package:flutter/material.dart';

class PassContent extends StatelessWidget {
  const PassContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'My Pass screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }
}
