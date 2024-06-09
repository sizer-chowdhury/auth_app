import 'dart:async';
import 'package:authentication_app/core/widgets/title_underline.dart';
import 'package:authentication_app/feature/email_confirmation/presentation/riverpod/email_confirmation_controller.dart';
import 'package:authentication_app/feature/email_confirmation/presentation/riverpod/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EmailConfirmationPage extends ConsumerStatefulWidget {
  final String email;
  final String pageSelector;

  const EmailConfirmationPage({
    required this.email,
    required this.pageSelector,
    super.key,
  });

  @override
  ConsumerState<EmailConfirmationPage> createState() =>
      _EmailConfirmationPageState();
}

class _EmailConfirmationPageState extends ConsumerState<EmailConfirmationPage> {
  TextEditingController otp = TextEditingController();
  bool enableButtonNotifier = false;
  Timer? _timer;
  int _countDown = 10;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    otp.addListener(
      () => updateEnableButtonNotifier(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countDown > 0) {
          _countDown--;
        } else {
          _timer?.cancel();
          canResend = true;
        }
      });
    });
  }

  void resendOtp() {
    if (canResend == true) {
      setState(() {
        _countDown = 10;
        canResend = false;
      });
      startTimer();
    }
  }

  void updateEnableButtonNotifier() {
    setState(() {
      enableButtonNotifier = otp.text.toString().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(emailConfirmationControllerProvider);

    ref.listen(emailConfirmationControllerProvider, (_, next) {
      if (next.value?.$1 != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Email verification successful'),
              content: const Text('Press OK'),
              actions: [
                TextButton(
                  onPressed: () {
                    if (widget.pageSelector == "signUp") {
                      context.go('/');
                    } else if (widget.pageSelector == "forgetPassword") {
                      context.go('/resetPassword/${widget.email}');
                    }
                    Navigator.of(context).pop();
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
              title: const Text('Failed'),
              content: const Text('OTP sent to your email.'),
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

    ref.listen(otpControllerProvider, (_, next) {
      if (next.value?.$1 != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Successful!'),
              content: Text('${next.value?.$1?.message}'),
              actions: [
                TextButton(
                  onPressed: () {
                    resendOtp();
                    Navigator.of(context).pop();
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
                    resendOtp();
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
                    'Email Confirmation..',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Underline(right: 77),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "We've sent a code to your email address",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Please check your inbox',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your code',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: '',
                      ),
                      controller: otp,
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
                          .read(emailConfirmationControllerProvider.notifier)
                          .emailConfirmation(
                            email: widget.email,
                            otp: otp.text.toString(),
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
              if (_countDown > 0)
                Text(
                  "Resend OTP in ${_countDown.toString()} seconds",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              if (_countDown == 0)
                TextButton(
                  onPressed: () {
                    ref.read(otpControllerProvider.notifier).resendEmail(
                          widget.email,
                        );
                  },
                  child: const Text("Resend OTP"),
                ),
              const SizedBox(height: 37),
            ],
          ),
        ),
      ),
    );
  }
}
