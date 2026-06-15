import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/authentications/viewModel/auth_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class SignInView extends GetView<AuthViewModel> {
  static const signInView = '/signInView';

  const SignInView({Key? key}) : super(key: key);

  static const Color _brandBlue = Color(0xff18548f);
  static const Color _fieldGray = Color(0xff6e6e6e);
  static const Color _borderGray = Color(0xffd6d6d6);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      init: AuthViewModel(),
      assignId: true,
      builder: (logic) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: _brandBlue,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: _brandBlue,
            body: SafeArea(
              bottom: false,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final minHeight = constraints.maxHeight;
                  final pageHeight = minHeight < 680.h ? 680.h : minHeight;
                  final sheetTop = pageHeight * 0.62;

                  return SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: minHeight),
                      child: SizedBox(
                        height: pageHeight,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              height: sheetTop + 34.h,
                              child: Container(color: _brandBlue),
                            ),
                            Positioned(
                              top: (sheetTop - 148.h)
                                  .clamp(300.h, 470.h)
                                  .toDouble(),
                              left: 30.w,
                              right: 30.w,
                              child: const _WelcomeTitle(),
                            ),
                            Positioned(
                              top: (pageHeight * 0.18)
                                  .clamp(95.h, 220.h)
                                  .toDouble(),
                              left: 0,
                              right: 0,
                              child: const _LogoBadge(),
                            ),
                            Positioned(
                              top: sheetTop,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: _LoginSheet(controller: controller),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LogoBadge extends StatelessWidget {
  const _LogoBadge();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 174.w,
        height: 174.w,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: 0.785398,
              child: Container(
                width: 39.w,
                height: 39.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: SignInView._brandBlue,
                    width: 1.7.w,
                  ),
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Transform.rotate(
                  angle: -0.785398,
                  child: Icon(
                    Icons.gps_fixed,
                    color: SignInView._brandBlue,
                    size: 28.w,
                  ),
                ),
              ),
            ),
            SizedBox(height: 22.h),
            Text(
              'GpsTrack Eye',
              style: TextStyle(
                color: SignInView._brandBlue,
                fontFamily: 'Dmsans',
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeTitle extends StatelessWidget {
  const _WelcomeTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome to\nGps Track Eye',
      style: TextStyle(
        color: AppColors.whiteColor,
        fontFamily: 'Dmsans',
        fontSize: 26.sp,
        fontWeight: FontWeight.w700,
        height: 1.4,
        letterSpacing: 0,
      ),
    );
  }
}

class _LoginSheet extends StatelessWidget {
  const _LoginSheet({required this.controller});

  final AuthViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34.r),
        ),
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(37.w, 48.h, 37.w, 34.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _AuthTextField(
              controller: controller.accountController,
              hintText: 'User Name',
              prefixIcon: Icons.person,
            ),
            SizedBox(height: 17.h),
            Obx(
              () => _AuthTextField(
                controller: controller.passwordController,
                hintText: 'Enter Password',
                prefixIcon: Icons.lock,
                obscureText: controller.obscurePassword.value,
                suffixIcon: controller.obscurePassword.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                onSuffixTap: controller.toggleObscurePassword,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Obx(
                  () => SizedBox(
                    width: 28.w,
                    height: 28.w,
                    child: Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: controller.toggleRememberMe,
                      activeColor: SignInView._brandBlue,
                      checkColor: AppColors.whiteColor,
                      side: BorderSide(
                        color: SignInView._brandBlue,
                        width: 2.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () =>
                      controller.toggleRememberMe(!controller.rememberMe.value),
                  child: Text(
                    'Dealer',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Dmsans',
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 61.h),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.20),
                    offset: Offset(0, 3.h),
                    blurRadius: 6.r,
                  ),
                ],
              ),
              child: SizedBox(
                height: 53.h,
                child: ElevatedButton(
                  onPressed: controller.login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SignInView._brandBlue,
                    foregroundColor: AppColors.whiteColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  child: Text(
                    AuthStrings.login.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Dmsans',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixTap,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58.h,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: SignInView._brandBlue,
        textInputAction:
            suffixIcon == null ? TextInputAction.next : TextInputAction.done,
        style: TextStyle(
          color: SignInView._fieldGray,
          fontFamily: 'Dmsans',
          fontSize: 22.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.whiteColor,
          hintText: hintText,
          hintStyle: TextStyle(
            color: SignInView._fieldGray,
            fontFamily: 'Dmsans',
            fontSize: 22.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: 0,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: SignInView._fieldGray,
            size: 27.w,
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 78.w,
            minHeight: 58.h,
          ),
          suffixIcon: suffixIcon == null
              ? null
              : IconButton(
                  onPressed: onSuffixTap,
                  icon: Icon(
                    suffixIcon,
                    color: SignInView._fieldGray,
                    size: 31.w,
                  ),
                ),
          contentPadding: EdgeInsets.only(
            top: 15.h,
            bottom: 15.h,
            right: 18.w,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: SignInView._borderGray,
              width: 1.5.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: SignInView._brandBlue,
              width: 1.6.w,
            ),
          ),
        ),
      ),
    );
  }
}
