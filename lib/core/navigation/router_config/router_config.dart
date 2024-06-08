import 'package:authentication_app/core/navigation/routes/routes_name.dart';
import 'package:authentication_app/feature/forget_password/presentation/pages/forget_password_page.dart';
import 'package:authentication_app/feature/login/presentation/pages/login_page.dart';
import 'package:authentication_app/feature/signup/presentations/pages/sign_up_page.dart';
import 'package:authentication_app/feature/home_page/presentation/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:authentication_app/feature/email_confirmation/presentation/views/email_confirmation_page.dart';
import 'package:authentication_app/feature/reset_password/presentation/views/reset_password_page.dart';

class MyRouterConfig {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: Routes.login,
        path: "/",
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginPage());
        },
      ),
      GoRoute(
        name: Routes.signup,
        path: "/signUp",
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignUpPage());
        },
      ),
      GoRoute(
        name: Routes.forgetPassword,
        path: "/forgetPassword",
        pageBuilder: (context, state) {
          return const MaterialPage(child: ForgetPasswordPage());
        },
      ),
      GoRoute(
        name: Routes.resetPassword,
        path: "/resetPassword/:email",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: ResetPasswordPage(
              email: state.pathParameters['email']!,
            ),
          );
        },
      ),
      GoRoute(
        name: Routes.emailConfirmation,
        path: "/emailConfirmation/:email/:pageSelector",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: EmailConfirmationPage(
              email: state.pathParameters['email']!,
              pageSelector: state.pathParameters['pageSelector']!,
            ),
          );
        },
      ),
      GoRoute(
        name: Routes.home,
        path: "/homePage",
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomePage());
        },
      ),
    ],
  );
}
