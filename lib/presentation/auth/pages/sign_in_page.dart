import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_app/common/widgets/appbar/basic_app_bar.dart';
import 'package:music_app/common/widgets/buttons/basic_app_button.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/data/models/auth/signin_user_req.dart';
import 'package:music_app/domain/usecases/auth/sign_in_usecase.dart';
import 'package:music_app/presentation/auth/pages/register_page.dart';
import 'package:music_app/presentation/home/pages/home_page.dart';
import 'package:music_app/service_locator.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
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
                    _signInTitle(context),
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
                        var result = await serviceLocator<SignInUsecase>().call(
                          params: SignInUserReq(
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
                      text: "Sign In",
                    ),
                    const Spacer(),
                    _registerText(context),
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

  Widget _signInTitle(BuildContext context) {
    return Text(
      "Sign In",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: "Email",
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
        hintText: "Password",
      ),
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _registerText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Not a member?",
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
                  return const RegisterPage();
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
            "Register Now",
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
