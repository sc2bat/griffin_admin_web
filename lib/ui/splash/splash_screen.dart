import 'dart:async';

import 'package:admin_web_app/ui/common/enums.dart';
import 'package:admin_web_app/ui/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription? _stremSubscription;
  @override
  void initState() {
    Future.microtask(() {
      final splashViewModel = context.read<SplashViewModel>();
      splashViewModel.init();
      _stremSubscription = splashViewModel.signResult.listen((event) {
        switch (event) {
          case SignStatus.signSuccess:
          case SignStatus.signFail:
          case SignStatus.isSignedIn:
            context.go('/dashboard');
          case SignStatus.isNotSignedIn:
            context.go('/sign');
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _stremSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final splashViewModel = context.watch<SplashViewModel>();
    final splashState = splashViewModel.splashState;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool isPop) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Pop Screen Disabled. You cannot go to previous screen.'),
            backgroundColor: Colors.red,
          ),
        );
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  '반갑습니다 ${splashState.accountModel != null ? splashState.accountModel!.userName : '관리자'} 님'),
              splashState.isLoading
                  ? const CircularProgressIndicator()
                  : Container(
                      child: const Text('Dashboard 로 이동합니다.'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
