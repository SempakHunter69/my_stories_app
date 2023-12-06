// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stories_app/common/styles.dart';
import 'package:my_stories_app/widgets/textformfield_widget.dart';

class LoginScreen extends StatefulWidget {
  final Function() goRegister;

  const LoginScreen({
    super.key,
    required this.goRegister,
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
                  errorMessage: '',
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  textEditingController: passwordController,
                  title: 'Password',
                  hintText: 'Masukkan password anda',
                  textInputType: TextInputType.text,
                  obscure: true,
                  errorMessage: '',
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Log In',
                      style:
                          myTextTheme.headline4!.copyWith(color: Colors.white),
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
}
