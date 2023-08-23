import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Color.fromARGB(255, 152, 152, 152),
            strokeWidth: 5,
          ),
        ],
      ),
    );
  }
}
