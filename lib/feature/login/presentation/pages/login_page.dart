import 'package:authentication_app/core/gen/assets.gen.dart';
import 'package:authentication_app/core/navigation/routes/routes_name.dart';
import 'package:authentication_app/core/gen/fonts.gen.dart';
import 'package:authentication_app/feature/home_page/controller/home_page_controller.dart';
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
    final loginState = ref.watch(loginProvider);
    ref.listen(loginProvider, (_, next) async {
      if (next.value != null) {
        context.go('/homePage');
      } else if (next.hasError && !next.isLoading) {
        _buildShowDialog(context);
      }
    });
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
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
                    controller: password,
                    hintText: 'Enter your password',
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
                       height: 15,
                       width: 15,
                       child:  Checkbox(
                         value: false,
                         onChanged: (newValue) {},

                       ),
                     ),
                      const SizedBox(width: 7),
                      Text(
                        'Remember Me',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      context.go("/forgetPassword");
                    },
                    child: Text(
                      'Forget Password?',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
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
                    ? () => ref.read(loginProvider.notifier).signIn(
                          email: email.text.toString(),
                          password: password.text.toString(),
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
                GoRouter.of(context).pushNamed(Routes.signup);
              },
              child: Text(
                "Don't have an account?Signup",
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
          content: const Text('Invalid Email or Password'),
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
