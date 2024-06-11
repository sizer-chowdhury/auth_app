import 'package:authentication_app/core/navigation/routes/routes_name.dart';
import 'package:authentication_app/core/widgets/password_filed.dart';
import 'package:authentication_app/core/widgets/title_underline.dart';
import 'package:authentication_app/feature/signup/presentations/riverpod/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  bool isButtonEnable = false;

  ({
    bool email,
    bool password,
    bool firstname,
    bool lastname
  }) enableButtonNotifier =
      (email: false, password: false, firstname: false, lastname: false);

  @override
  void initState() {
    super.initState();
    firstname.addListener(
      () => updateEnableButtonNotifier(),
    );

    lastname.addListener(
      () => updateEnableButtonNotifier(),
    );
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
        firstname: firstname.value.text.isNotEmpty,
        lastname: lastname.value.text.isNotEmpty,
        email: email.value.text.isNotEmpty,
        password: password.value.text.isNotEmpty
      );
      isButtonEnable = enableButtonNotifier.email &&
          enableButtonNotifier.password &&
          enableButtonNotifier.firstname &&
          enableButtonNotifier.lastname;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(signupProvider);

    ref.listen(signupProvider, (_, next) {
      if (next.value?.$1 != null && next.value?.$2 == null) {
        String? emailController = email.text.toString();
        String pageSelector = "signUp";
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Account Created successfully!'),
              content: const Text('Press OK and verify your email.'),
              actions: [
                TextButton(
                  onPressed: () {
                    context.go(
                      '/emailConfirmation/$emailController/$pageSelector',
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (next.value?.$1 == null && next.value?.$2 != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('User already exist. Please Login'),
              content: Text('${next.value?.$2}'),
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
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Text(
                      'Sign Up With Email',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Underline(right: 77),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  'Get chatting with friends and family today by',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'signing up for our chat app!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First name',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: '',
                        ),
                        controller: firstname,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Last name',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: '',
                        ),
                        controller: lastname,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Your email',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: '',
                        ),
                        controller: email,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Password',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      PasswordField(
                        controller: password,
                        hintText: '', errorPasswordVal: '',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 94),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: ElevatedButton(
                    onPressed: (isButtonEnable)
                        ? () => ref.read(signupProvider.notifier).signUp(
                              firstname: firstname.text.toString(),
                              lastname: lastname.text.toString(),
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
                            'Create an account',
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
                    GoRouter.of(context).pushNamed(Routes.login);
                  },
                  child: Text(
                    'Already have an account? Log In',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
