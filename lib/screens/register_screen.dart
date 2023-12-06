// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stories_app/common/styles.dart';
import 'package:my_stories_app/widgets/textformfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  final Function() goLogin;

  const RegisterScreen({
    super.key,
    required this.goLogin,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
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
                  'assets/register.png',
                  height: 300,
                ),
                Text(
                  'Register',
                  style: myTextTheme.headline1,
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  textEditingController: emailController,
                  title: 'Nama',
                  hintText: 'Masukkan nama lengkap anda',
                  textInputType: TextInputType.text,
                  obscure: false,
                  errorMessage: '',
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  textEditingController: emailController,
                  title: 'Email',
                  hintText: 'Masukkan Email anda',
                  textInputType: TextInputType.emailAddress,
                  obscure: false,
                  errorMessage: '',
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  textEditingController: passwordController,
                  title: 'Password',
                  hintText: 'Masukkan Password anda',
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
                      'Register',
                      style:
                          myTextTheme.headline4!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account ? ',
                      style:
                          myTextTheme.subtitle1!.copyWith(color: Colors.grey),
                      children: [
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {
                              widget.goLogin();
                            },
                            child: Text(
                              'Sign In',
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
