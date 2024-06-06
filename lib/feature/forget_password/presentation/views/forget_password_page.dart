import 'package:authentication_app/core/navigation/routes/routes_name.dart';
import 'package:authentication_app/core/widgets/title_underline.dart';
import 'package:authentication_app/feature/forget_password/controller/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordPage extends ConsumerStatefulWidget {
  const ForgetPasswordPage({
    super.key,
  });

  @override
  ConsumerState<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends ConsumerState<ForgetPasswordPage> {
  TextEditingController email = TextEditingController();
  bool enableButtonNotifier = false;

  @override
  void initState() {
    super.initState();

    email.addListener(
      () => updateEnableButtonNotifier(),
    );
  }

  void updateEnableButtonNotifier() {
    setState(() {
      enableButtonNotifier = email.text.toString().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(forgetPasswordProvider);

    ref.listen(forgetPasswordProvider, (_, next) {
      if (next.value ?? false) {
        String? emailController = email.text.toString();
        String pageSelector = "forgetPassword";
        context.go('/emailConfirmation/$emailController/$pageSelector');
      } else if (next.hasError && !next.isLoading) {
        _buildShowDialog(context);
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
        child: Column(
          children: [
            Stack(
              children: [
                Text(
                  'Forgot Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Underline(right: 77),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Enter your email address. We will send a code',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'to verify your identity',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your email',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                    controller: email,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: ElevatedButton(
                onPressed: (enableButtonNotifier)
                    ? () => ref
                        .read(forgetPasswordProvider.notifier)
                        .otpConfirmation(
                          email: email.text.toString(),
                        )
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: (enableButtonNotifier)
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: loginState.isLoading
                    ? const CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                    : Text(
                        'Submit',
                        style: TextStyle(
                          color: (enableButtonNotifier)
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.go("/");
              },
              child: Text(
                'Remember your password? Log In',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 37),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error! Bad request.'),
          content: const Text('Invalid Email'),
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
}
