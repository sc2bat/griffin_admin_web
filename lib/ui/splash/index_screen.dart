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
            child: const SizedBox(
              height: 60.0,
              child: Text('/dashboard'),
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/flight'),
            child: const SizedBox(
              height: 60.0,
              child: Text('/flight'),
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/airport'),
            child: const SizedBox(
              height: 60.0,
              child: Text('/airport'),
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/reservation'),
            child: const SizedBox(
              height: 60.0,
              child: Text('/reservation'),
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/usermanage'),
            child: const SizedBox(
              height: 60.0,
              child: Text('/usermanage'),
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/payment'),
            child: const SizedBox(
              height: 60.0,
              child: Text('/payment'),
            ),
          ),
        ],
      ),
    );
  }
}
