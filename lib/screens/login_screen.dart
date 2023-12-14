// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stories_app/common/styles.dart';
import 'package:my_stories_app/provider/preferences_provider.dart';
import 'package:my_stories_app/provider/user_provider.dart';
import 'package:my_stories_app/widgets/textformfield_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final Function() goRegister;
  final Function() onLogin;

  const LoginScreen({
    super.key,
    required this.goRegister,
    required this.onLogin,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'assets/login.png',
                  height: 300,
                ),
                Text(
                  'Log In',
                  style: myTextTheme.headline1,
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  textEditingController: emailController,
                  title: 'Email',
                  hintText: 'Masukkan email anda',
                  textInputType: TextInputType.emailAddress,
                  obscure: false,
                  errorMessage: 'Harap masukkan email anda !',
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  textEditingController: passwordController,
                  title: 'Password',
                  hintText: 'Masukkan password anda',
                  textInputType: TextInputType.text,
                  obscure: true,
                  errorMessage: 'Harap masukkan password anda !',
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      _onLogin();
                    },
                    child: context.watch<UserProvider>().isLogin
                        ? const CircularProgressIndicator()
                        : Text(
                            'Log In',
                            style: myTextTheme.headline4!
                                .copyWith(color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Don\'t have an account ? ',
                      style:
                          myTextTheme.subtitle1!.copyWith(color: Colors.grey),
                      children: [
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {
                              widget.goRegister();
                            },
                            child: Text(
                              'Sign Up',
                              style: myTextTheme.subtitle1!
                                  .copyWith(color: Colors.purple[300]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  _onLogin() async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    if (formKey.currentState!.validate()) {
      final userProvider = context.read<UserProvider>();
      final preferencesProvider = context.read<PreferencesProvider>();
      await userProvider.loginUser(
        emailController.text,
        passwordController.text,
      );
      if (userProvider.loginRespose?.loginResult.token != null) {
        widget.onLogin();
        preferencesProvider
            .saveToken(userProvider.loginRespose!.loginResult.token);
        scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text(userProvider.message)),
        );
      } else {
        scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text(userProvider.message)),
        );
      }
    }
  }
}
