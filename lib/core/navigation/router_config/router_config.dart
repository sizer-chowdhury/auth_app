import 'package:authentication_app/core/navigation/routes/routes_name.dart';
import 'package:authentication_app/feature/email_confirmation/presentation/pages/email_confirmation_page.dart';
import 'package:authentication_app/feature/forget_password/presentation/pages/forget_password_page.dart';
import 'package:authentication_app/feature/home_page/presentation/pages/home_page.dart';
import 'package:authentication_app/feature/login/presentation/pages/login_page.dart';
import 'package:authentication_app/feature/reset_password/presentation/pages/reset_password_page.dart';
import 'package:authentication_app/feature/signup/presentations/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyRouterConfig {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        //name: Routes.login,
        path: Routes.login,
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginPage());
        },
      ),
      GoRoute(
        //name: Routes.signup,
        path: Routes.signup,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignUpPage());
        },
      ),
      GoRoute(
        //name: Routes.forgetPassword,
        path: Routes.forgetPassword,
        pageBuilder: (context, state) {
          return const MaterialPage(child: ForgetPasswordPage());
        },
      ),
      GoRoute(
        //name: Routes.resetPassword,
        path: Routes.resetPassword,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String,String>;
          return MaterialPage(
            child: ResetPasswordPage(
              email: data['email']!,
            ),
          );
        },
      ),
      GoRoute(
        //name: Routes.emailConfirmation,
        path: Routes.emailConfirmation,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, String>;
          return MaterialPage(
            child: EmailConfirmationPage(
              email: data['email']!,
              pageSelector: data['pageSelector']!,
            ),
          );
        },
      ),
      GoRoute(
        // name: Routes.home,
        path: Routes.home,
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomePage());
        },
      ),
    ],
  );
}