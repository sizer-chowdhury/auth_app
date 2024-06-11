import 'package:authentication_app/core/navigation/routes/routes_name.dart';
import 'package:authentication_app/core/widgets/password_filed.dart';
import 'package:authentication_app/core/widgets/title_underline.dart';
import 'package:authentication_app/feature/reset_password/presentation/riverpod/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  final String email;
  final String previousPage = "forgetPassword";

  const ResetPasswordPage({super.key, required this.email});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isButtonEnable = false;

  ({bool password, bool confirmPassword}) enableButtonNotifier =
      (password: false, confirmPassword: false);

  @override
  void initState() {
    super.initState();

    password.addListener(
      () => updateEnableButtonNotifier(),
    );
    confirmPassword.addListener(
      () => updateEnableButtonNotifier(),
    );
  }

  void updateEnableButtonNotifier() {
    setState(() {
      enableButtonNotifier = (
        password: password.value.text.isNotEmpty,
        confirmPassword: confirmPassword.value.text.isNotEmpty
      );
      isButtonEnable =
          enableButtonNotifier.password && enableButtonNotifier.confirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(resetPasswordControllerProvider);

    ref.listen(resetPasswordControllerProvider, (_, next) {
      if (next.value?.$1 != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('successful!'),
              content: Text('${next.value?.$1?.message}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.go(Routes.login);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (next.value?.$2 != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error!'),
              content: Text('${next.value?.$2?.toString()}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  Text(
                    'Reset Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Underline(right: 77),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Please enter a new password. Don't enter",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'your old password',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    PasswordField(
                      controller: password,
                      hintText: '', errorPasswordVal: '',
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Confirm Password',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    PasswordField(
                      controller: confirmPassword,
                      hintText: '', errorPasswordVal: '',
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: ElevatedButton(
                  onPressed: (isButtonEnable)
                      ? () => ref
                          .read(resetPasswordControllerProvider.notifier)
                          .resetPassword(
                            email: widget.email,
                            password: password.text.toString(),
                            confirmPassword: confirmPassword.text.toString(),
                          )
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (isButtonEnable)
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: loginState.isLoading
                      ? const CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      : Text(
                          'Reset Password',
                          style: TextStyle(
                            color: (isButtonEnable)
                                ? Theme.of(context).colorScheme.surface
                                : Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 37),
            ],
          ),
        ),
      ),
    );
  }
}
