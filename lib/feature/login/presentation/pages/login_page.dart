import 'package:authentication_app/core/gen/assets.gen.dart';
import 'package:authentication_app/core/navigation/routes/routes_name.dart';
import 'package:authentication_app/core/gen/fonts.gen.dart';
import 'package:authentication_app/feature/login/presentation/widgets/circular_tile.dart';
import 'package:authentication_app/core/widgets/password_filed.dart';
import 'package:authentication_app/core/widgets/title_underline.dart';
import 'package:authentication_app/feature/login/presentation/riverpod/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isButtonEnable = false;
  bool enableCheckbox = false;
  bool? isLogin = false;
  String errorPasswordVal = '';

  ({bool email, bool password}) enableButtonNotifier =
      (email: false, password: false);

  @override
  void initState() {
    super.initState();
    email.clear();
    password.clear();
    email.addListener(
      () => updateEnableButtonNotifier(),
    );
    password.addListener(
      () => updateEnableButtonNotifier(),
    );
  }

  void updateEnableButtonNotifier() {
    setState(() {
      enableButtonNotifier = (
        email: email.value.text.isNotEmpty,
        password: password.value.text.isNotEmpty,
      );
      isButtonEnable =
          enableButtonNotifier.email && enableButtonNotifier.password;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(signInProvider);
    ref.listen(signInProvider, (_, next) async {
      if (next.value != null) {
        context.go(Routes.home);
      } else if (next.hasError && !next.isLoading) {
        String message = next.error.toString();
        if (message.startsWith('Exception: ')) {
          message = message.substring('Exception: '.length);
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error! Bad request.'),
              content: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 45),
              Stack(
                children: [
                  Text(
                    'Log In to Authy',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Underline(right: 77),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome back! Sign in using your social',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'account or email to continue us',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginPageLogo(
                    logo: Image(
                      image: Assets.assets.images.facebook.provider(),
                      height: 25,
                      width: 25,
                    ),
                  ),
                  const SizedBox(width: 22),
                  LoginPageLogo(
                    logo: Image(
                      image: Assets.assets.images.google.provider(),
                      height: 25,
                      width: 25,
                    ),
                  ),
                  const SizedBox(width: 22),
                  LoginPageLogo(
                    logo: Image(
                      image: Assets.assets.images.apple.provider(),
                      height: 25,
                      width: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFFCDD1D0),
                      ),
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontFamily: FontFamily.circular,
                        color: Color(0xFFCDD1D0),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFFCDD1D0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                      ),
                      controller: email,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    PasswordField(
                      onChanged: (value) {
                        setState(() {
                          if (value.length < 6) {
                            errorPasswordVal = 'Password length must be'
                                ' greater than or equal to 6';
                          } else {
                            errorPasswordVal = '';
                          }
                        });
                      },
                      controller: password,
                      hintText: 'Enter your password',
                      errorPasswordVal: errorPasswordVal,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 10,
                          width: 18,
                          child: Checkbox(
                            value: enableCheckbox,
                            onChanged: (newValue) {
                              setState(() {
                                enableCheckbox = newValue ?? false;
                                isLogin = true;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            fillColor: (enableCheckbox)
                                ? WidgetStatePropertyAll(
                                    Theme.of(context).colorScheme.primary,
                                  )
                                : WidgetStatePropertyAll(
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5),
                                  ),
                            side: (enableCheckbox)
                                ? BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.1),
                                    width: 2,
                                  )
                                : BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              enableCheckbox = !enableCheckbox;
                            });
                          },
                          child: Text(
                            'Remember Me',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        // Text(
                        //   'Remember Me',
                        //   style: Theme.of(context).textTheme.headlineLarge,
                        // ),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        context.push(Routes.forgetPassword);
                      },
                      child: Text(
                        'Forget Password?',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 148),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: ElevatedButton(
                  onPressed: (isButtonEnable)
                      ? () => ref.read(signInProvider.notifier).signIn(
                            email: email.text.toString(),
                            password: password.text.toString(),
                            isLogin: isLogin,
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
                          'Login',
                          style: TextStyle(
                            color: (isButtonEnable)
                                ? Theme.of(context).colorScheme.surface
                                : Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.go(Routes.signup);
                },
                child: Text(
                  "Don't have an account? Signup",
                  style: Theme.of(context).textTheme.headlineLarge,
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
