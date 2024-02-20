import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => context.push('/dashboard'),
            child: Container(
              child: const Text('/dashboard'),
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/dashboard'),
            child: Container(
              child: const Text('/dashboard'),
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/dashboard'),
            child: Container(
              child: const Text('/dashboard'),
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/dashboard'),
            child: Container(
              child: const Text('/dashboard'),
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/dashboard'),
            child: Container(
              child: const Text('/dashboard'),
            ),
          ),
        ],
      ),
    );
  }
}
