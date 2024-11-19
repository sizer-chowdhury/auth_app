import 'package:authentication_app/core/navigation/routes/routes_name.dart';
import 'package:authentication_app/feature/email_confirmation/presentation/pages/email_confirmation_page.dart';
import 'package:authentication_app/feature/forget_password/presentation/pages/forget_password_page.dart';
import 'package:authentication_app/feature/home_page/presentation/pages/home_page.dart';
import 'package:authentication_app/feature/login/presentation/pages/login_page.dart';
import 'package:authentication_app/feature/reset_password/presentation/pages/reset_password_page.dart';
import 'package:authentication_app/feature/signup/presentations/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyRouterConfig {
  static GoRouter router = GoRouter(
    initialLocation: Routes.login,
    routes: [
      GoRoute(
        path: Routes.login,
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginPage());
        },
      ),
      GoRoute(
        path: Routes.signup,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignUpPage());
        },
      ),
      GoRoute(
        path: Routes.forgetPassword,
        pageBuilder: (context, state) {
          return const MaterialPage(child: ForgetPasswordPage());
        },
      ),
      GoRoute(
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
        path: Routes.home,
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomePage());
        },
      ),
    ],
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('loggedInEmail');
      final isLoggedIn = (email != null);

      if (isLoggedIn && state.fullPath == Routes.login) {
        return Routes.home;
      } else if (!isLoggedIn && state.fullPath == Routes.login) {
        return Routes.login;
      }
      return null;
    },
  );
}