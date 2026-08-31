import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/repository/user_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';

class IntroSliderView extends StatefulWidget {
  const IntroSliderView({required this.fromSettingSlider});
  final bool fromSettingSlider;

  @override
  _IntroSliderViewState createState() => _IntroSliderViewState();
}

class _IntroSliderViewState extends State<IntroSliderView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UserProvider? userProvider;
  UserRepository? userRepo;
  PsValueHolder? psValueHolder;
  int currentIndex = 0;
  final int sliderPageCount = 3;

  final List<String> pictureList = <String>[
    'assets/images/11.png',
    'assets/images/12.png',
    'assets/images/13.png',
  ];

  final List<String> titleList = <String>[
    'intro_slider1_title',
    'intro_slider2_title',
    'intro_slider3_title',
  ];

  final List<String> descriptionList = <String>[
    'intro_slider1_description',
    'intro_slider2_description',
    'intro_slider3_description',
  ];

  @override
  Widget build(BuildContext context) {
    userRepo = Provider.of<UserRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return ChangeNotifierProvider<UserProvider?>(
      lazy: false,
      create: (BuildContext context) {
        userProvider =
            UserProvider(repo: userRepo, psValueHolder: psValueHolder);
        return userProvider;
      },
      child: Consumer<UserProvider>(
        builder: (BuildContext context, UserProvider provider, Widget? child) {
          return Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: GestureDetector(
                onHorizontalDragEnd: (DragEndDetails endDetails) {
                  if (endDetails.primaryVelocity! < 0) {
                    if (currentIndex < sliderPageCount - 1) {
                      setState(() => currentIndex++);
                    }
                  } else if (endDetails.primaryVelocity! > 0) {
                    if (currentIndex > 0) {
                      setState(() => currentIndex--);
                    }
                  }
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    // Full-screen image
                    Image.asset(
                      pictureList[currentIndex],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    // Dark gradient at bottom for readable text
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.transparent,
                            Colors.black.withOpacity(0.15),
                            Colors.black.withOpacity(0.75),
                          ],
                          stops: const <double>[0.0, 0.45, 1.0],
                        ),
                      ),
                    ),
                    // Skip (Passer)
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () => _goNext(provider),
                          child: Text(
                            'intro_slider_skip'.tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Bottom content
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: PsDimens.space24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              titleList[currentIndex].tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: PsDimens.space12),
                            Text(
                              descriptionList[currentIndex].tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 15,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: PsDimens.space24),
                            // Dots
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List<Widget>.generate(
                                sliderPageCount,
                                    (int i) => Container(
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 4),
                                  width: i == currentIndex ? 20 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: i == currentIndex
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: PsDimens.space24),
                            // Sign up button
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RoutePaths.user_register_container);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4CD4A0),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                                child: Text(
                                  'login__sign_up'.tr, // or custom key
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: PsDimens.space16),
                            // Already have account → Login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'login__already_have_account'.tr,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutePaths.login_container);
                                  },
                                  child: Text(
                                    'login__sign_in'.tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: PsDimens.space24),
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
      ),
    );
  }

  Future<void> _goNext(UserProvider provider) async {
    if (widget.fromSettingSlider) {
      Navigator.pop(context);
      return;
    }
    // Mark intro as seen (same as original explore/skip logic)
    await provider.replaceIsToShowIntroSlider(false);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, RoutePaths.home);
  }
}