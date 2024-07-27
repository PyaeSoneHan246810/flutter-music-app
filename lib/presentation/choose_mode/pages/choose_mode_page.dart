import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/common/widgets/buttons/basic_app_button.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';
import 'package:music_app/presentation/choose_mode/bloc/cubit/theme_cubit.dart';
import 'package:music_app/presentation/auth/pages/register_or_sign_in_page.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.chooseModeBg),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.15),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppVectors.appLogo,
                      ),
                      const Spacer(),
                      const Text(
                        "Choose Mode",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: AppColors.darkOnSurface,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              ClipOval(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                  child: IconButton.filled(
                                    onPressed: () {
                                      context
                                          .read<ThemeCubit>()
                                          .updateTheme(ThemeMode.dark);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        AppColors.darkSurface.withOpacity(0.5),
                                      ),
                                      foregroundColor:
                                          const WidgetStatePropertyAll(
                                        AppColors.darkOnSurface,
                                      ),
                                      padding: const WidgetStatePropertyAll(
                                        EdgeInsets.all(20),
                                      ),
                                      iconSize:
                                          const WidgetStatePropertyAll(40),
                                    ),
                                    icon: const Icon(
                                      Icons.dark_mode_outlined,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const Text(
                                "Dark Mode",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.darkOnSurface,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Column(
                            children: [
                              ClipOval(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                  child: IconButton.filled(
                                    onPressed: () {
                                      context
                                          .read<ThemeCubit>()
                                          .updateTheme(ThemeMode.light);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        AppColors.darkSurface.withOpacity(0.5),
                                      ),
                                      foregroundColor:
                                          const WidgetStatePropertyAll(
                                        AppColors.darkOnSurface,
                                      ),
                                      padding: const WidgetStatePropertyAll(
                                        EdgeInsets.all(20),
                                      ),
                                      iconSize:
                                          const WidgetStatePropertyAll(40),
                                    ),
                                    icon: const Icon(
                                      Icons.light_mode_outlined,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const Text(
                                "Light Mode",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.darkOnSurface,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      BasicAppButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const RegisterOrSignInPage();
                              },
                            ),
                          );
                        },
                        text: "Continue",
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
