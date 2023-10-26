import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return render(context);
  }

  render(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                headerContainer(context),
                formContainer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  headerContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      alignment: const AlignmentDirectional(-1.0, 0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
        child: Text(
          'BigBlue',
          style: TextStyle(
              fontSize: 35,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  formContainer(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'Welcome Back',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            const Text(
              'Let\'s get started by filling out the form below.',
            ),
            signInForm(context),
            signUp(context),
            forgotPass()
          ],
        ),
      ),
    );
  }

  signInForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 20, bottom: 10),
      child: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 16),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(height: 1),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.black87),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 16),
              child: TextFormField(
                autocorrect: false,
                enableSuggestions: false,
                obscureText: true,
                style: const TextStyle(height: 1),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.black87),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: const Icon(
                    Icons.visibility_off,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (kDebugMode) {
                  print('Login clicked');
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor),
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(double.maxFinite, 50),
                ),
                textStyle: const MaterialStatePropertyAll(
                  TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              child: const Text('Sign In'),
            )
          ],
        ),
      ),
    );
  }

  signUp(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        TextButton(
          onPressed: () {
            if (kDebugMode) {
              print('Navigate to screen Sign up');
            }
          },
          child: Text(
            'Sign Up Here',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }

  forgotPass() {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 32),
        child: TextButton(
          onPressed: () {
            if (kDebugMode) {
              print('Navigate to screen forgot');
            }
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.black54, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
