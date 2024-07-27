import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/common/widgets/appbar/basic_app_bar.dart';
import 'package:music_app/common/widgets/buttons/basic_app_button.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/data/models/auth/create_user_req.dart';
import 'package:music_app/domain/usecases/auth/sign_up_usecase.dart';
import 'package:music_app/presentation/auth/pages/sign_in_page.dart';
import 'package:music_app/presentation/home/pages/home_page.dart';
import 'package:music_app/service_locator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        title: SvgPicture.asset(
          AppVectors.appLogo,
          height: 36,
          fit: BoxFit.cover,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    _registerTitle(context),
                    const SizedBox(
                      height: 20,
                    ),
                    _usernameField(context),
                    const SizedBox(
                      height: 20,
                    ),
                    _emailField(context),
                    const SizedBox(
                      height: 20,
                    ),
                    _passwordField(context),
                    const SizedBox(
                      height: 20,
                    ),
                    BasicAppButton(
                      onPressed: () async {
                        var result = await serviceLocator<SignUpUsecase>().call(
                          params: CreateUserReq(
                            fullName:
                                _fullNameController.text.toString().trim(),
                            email: _emailController.text.toString().trim(),
                            password:
                                _passwordController.text.toString().trim(),
                          ),
                        );
                        result.fold(
                          (errorMessage) {
                            var snackBar = SnackBar(
                              content: Text(errorMessage),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          (successMessage) {
                            var snackBar = SnackBar(
                              content: Text(successMessage),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const RootPage();
                                },
                              ),
                              (route) => false,
                            );
                          },
                        );
                      },
                      text: "Create Account",
                    ),
                    const Spacer(),
                    _signInText(context),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _registerTitle(BuildContext context) {
    return Text(
      "Register",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _usernameField(BuildContext context) {
    return TextField(
      controller: _fullNameController,
      decoration: const InputDecoration(
        hintText: "Enter Username",
      ),
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: "Enter Email",
      ),
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      decoration: const InputDecoration(
        hintText: "Enter Password",
      ),
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Do you have an account?",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SignInPage();
                },
              ),
            );
          },
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.primary,
            ),
          ),
          child: const Text(
            "Sign In",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
