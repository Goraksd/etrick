import 'package:etrick/constants.dart';
import 'package:etrick/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailTextFieldController = TextEditingController();
  final isEmailError = ValueNotifier<bool>(false);

  void _login() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      context.go(Constants.loginLoc);
    }
  }

  Future<void> _resetPassword() async {
    isEmailError.value = false;
    String email = emailTextFieldController.value.text.trim().toLowerCase();

    if (!context.read<AuthService>().isEmailValid(email)) {
      isEmailError.value = true;
      return;
    }

    final result = await context.read<AuthService>().resetPassword(email);
    bool success = result.keys.first;
    String e = result.values.first;
    if (!success && mounted) {
      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(context.read<AuthService>().getFirebaseAuthErrorMessage(e)),
        ),
      );
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
            'На вашу єлектронну адресу надіслано листа з посиланням для зміни паролю.'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Login',
          onPressed: _login,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Відновлення паролю'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  'ETRICK',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder(
                  valueListenable: isEmailError,
                  builder: (context, error, _) {
                    return TextField(
                      controller: emailTextFieldController,
                      decoration: InputDecoration(
                        labelText: 'Електронна адреса',
                        errorText: error
                            ? 'Будь ласка, введіть коректну адресу'
                            : null,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _resetPassword,
                  child: const Text('Відновити пароль'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: _login,
                  child: const Text('Увійти'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
