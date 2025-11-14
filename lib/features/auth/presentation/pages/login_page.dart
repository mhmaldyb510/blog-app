import 'package:blog_app/core/common/widgets/loading_screen.dart';
import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/core/utils/show_snake_bar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          showSnackBar(
            'User logged in successfully',
            context,
            color: AppPalette.gradient3,
          );
        }
        if (state is AuthFailure) {
          showSnackBar(state.message, context, color: AppPalette.errorColor);
        }
      },
      builder: (context, state) {
        return state is AuthLoading
            ? const LoadingScreen()
            : Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sign In.',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        AuthField(hint: 'Email', controller: emailController),
                        const SizedBox(height: 15),
                        AuthField(
                          hint: 'Password',
                          controller: passwordController,
                          isObscureText: true,
                        ),
                        const SizedBox(height: 20),
                        AuthGradientButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                AuthLogIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                            }
                          },
                          text: 'Sign In',
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: 'Don\'t have an account? ',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: const [
                                TextSpan(
                                  text: 'Sign Up.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppPalette.gradient2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
