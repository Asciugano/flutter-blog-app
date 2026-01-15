import 'package:blog/core/common/widgets/loader.dart';
import 'package:blog/core/theme/palette.dart';
import 'package:blog/core/utils/show_snacbar.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/pages/login_page.dart';
import 'package:blog/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingupPage extends StatefulWidget {
  static MaterialPageRoute<SingupPage> route() =>
      MaterialPageRoute(builder: (context) => SingupPage());
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnacBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sing Up',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 30),
                  AuthField(hintText: 'Name', controller: nameController),

                  const SizedBox(height: 15),
                  AuthField(hintText: 'Email', controller: emailController),

                  const SizedBox(height: 15),
                  AuthField(
                    hintText: 'Password',
                    controller: passwController,
                    isPassword: true,
                  ),

                  const SizedBox(height: 20),
                  GradientButton(
                    text: 'Sing up',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSignUp(
                            email: emailController.text.trim(),
                            name: nameController.text.trim(),
                            password: passwController.text.trim(),
                          ),
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.push(context, SinginPage.route()),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sing in',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppPalette.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
