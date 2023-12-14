// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stories_app/common/styles.dart';
import 'package:my_stories_app/provider/user_provider.dart';
import 'package:my_stories_app/widgets/textformfield_widget.dart';
import 'package:provider/provider.dart';

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
                  textEditingController: nameController,
                  title: 'Nama',
                  hintText: 'Masukkan nama lengkap anda',
                  textInputType: TextInputType.text,
                  obscure: false,
                  errorMessage: 'Harap masukkan nama anda !',
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  textEditingController: emailController,
                  title: 'Email',
                  hintText: 'Masukkan Email anda',
                  textInputType: TextInputType.emailAddress,
                  obscure: false,
                  errorMessage: 'Harap masukkan email anda !',
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  textEditingController: passwordController,
                  title: 'Password',
                  hintText: 'Masukkan Password anda',
                  textInputType: TextInputType.text,
                  obscure: true,
                  errorMessage:
                      'Harap masukkan password anda ! minimal 8 karakter !',
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () => _onRegister(),
                    child: context.watch<UserProvider>().isRegister
                        ? const CircularProgressIndicator()
                        : Text(
                            'Register',
                            style: myTextTheme.headline4!
                                .copyWith(color: Colors.white),
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

  _onRegister() async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    final userProvider = context.read<UserProvider>();
    if (formKey.currentState!.validate()) {
      await userProvider.registerUser(
        nameController.text,
        emailController.text,
        passwordController.text,
      );

      if (userProvider.message == 'User created') {
        widget.goLogin();
      }
      scaffoldMessengerState.showSnackBar(
        SnackBar(content: Text(userProvider.message)),
      );
    }
  }
}
