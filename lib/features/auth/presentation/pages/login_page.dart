import 'package:blog/core/theme/palette.dart';
import 'package:blog/features/auth/presentation/pages/singup_page.dart';
import 'package:blog/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class SinginPage extends StatefulWidget {
  static MaterialPageRoute<SinginPage> route() =>
      MaterialPageRoute(builder: (context) => SinginPage());
  const SinginPage({super.key});

  @override
  State<SinginPage> createState() => _SinginPageState();
}

class _SinginPageState extends State<SinginPage> {
  final emailController = TextEditingController();
  final passwController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sing In',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),
              AuthField(hintText: 'Email', controller: emailController),

              const SizedBox(height: 15),
              AuthField(
                hintText: 'Password',
                controller: passwController,
                isPassword: true,
              ),

              const SizedBox(height: 20),
              GradientButton(text: 'Sing in', onPressed: () {}),

              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.push(context, SingupPage.route()),
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Sing up',
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
        ),
      ),
    );
  }
}
