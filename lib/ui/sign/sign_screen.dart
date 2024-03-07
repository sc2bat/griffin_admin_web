import 'dart:async';

import 'package:admin_web_app/env/env.dart';
import 'package:admin_web_app/ui/common/common.dart';
import 'package:admin_web_app/ui/sign/sign_result.dart';
import 'package:admin_web_app/ui/sign/sign_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  StreamSubscription? _subscription;

  @override
  void initState() {
    Future.microtask(() {
      final signViewModel = context.read<SignViewModel>();
      _subscription = signViewModel.signResult.listen((event) {
        switch (event) {
          case SignResult.signSuccess:
            context.go('/splash');
          case SignResult.signFail:
            showCustomDialog(
              context,
              cancelable: false,
              isVisibleCancelButton: false,
              title: '로그인 오류',
              content: '아이디 비밀번호를 재확인해주세요',
            );
        }
      });
    });
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();

    _userNameController.text = Env.sampleAccountUsername;
    _passwordController.text = Env.sampleAccountPassword;

    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signViewModel = context.watch<SignViewModel>();
    final singState = signViewModel.signState;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('GRIFFIN ADMIN WEB'),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * 0.3,
            maxWidth: MediaQuery.of(context).size.width * 0.5,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _userNameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'UserName',
                    ),
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return 'Please enter your user name';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  singState.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              String userName = _userNameController.text;
                              String password = _passwordController.text;
                              signViewModel.signIn(
                                  userName: userName, password: password);
                            }
                          },
                          child: const Text('Admin SignIn'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
