import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app_mob/config/routes/app_routes.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/extensions/validation.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailText = TextEditingController();
  final TextEditingController _passwordText = TextEditingController();
  bool _isShowPassword = false;
  bool _hasEmail = false;
  bool _hasPassword = false;

  @override
  void initState() {
    super.initState();
    _emailText.addListener(() {
      bool res = _emailText.text.isNotEmpty;

      setState(() => _hasEmail = res);
    });
    _passwordText.addListener(() {
      bool res = _passwordText.text.isNotEmpty;

      setState(() => _hasPassword = res);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _emailText.dispose();
    _passwordText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return render(context);
  }

  Widget render(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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

  Widget headerContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      alignment: const AlignmentDirectional(-1.0, 0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
        child: Text(
          'BigBlue',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: Theme.of(context).textTheme.displaySmall?.fontSize,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget formContainer(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            'Welcome Back',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          Text('Let\'s get started by filling out the form below.',
              style: Theme.of(context).textTheme.bodySmall),
          signInForm(context),
          signUp(context),
          forgotPass(context)
        ],
      ),
    );
  }

  Widget signInForm(BuildContext context) {
    final textFieldEnabledBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(12),
    );

    final textFieldFocusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 1.5),
      borderRadius: BorderRadius.circular(12),
    );

    final errorFieldFocusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
      borderRadius: BorderRadius.circular(12),
    );

    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 20, bottom: 10),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 16),
              child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailText,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(height: 1),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.black87),
                    enabledBorder: textFieldEnabledBorder,
                    focusedBorder: textFieldFocusedBorder,
                    errorBorder: errorFieldFocusedBorder,
                    focusedErrorBorder: errorFieldFocusedBorder,
                  ),
                  validator: (value) {
                    return value != null && !value.isValidEmail
                        ? 'Enter a valid email'
                        : null;
                  }),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 16),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _passwordText,
                autocorrect: false,
                enableSuggestions: false,
                obscureText: _isShowPassword ? false : true,
                style: const TextStyle(height: 1),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.black87),
                  enabledBorder: textFieldEnabledBorder,
                  focusedBorder: textFieldFocusedBorder,
                  errorBorder: errorFieldFocusedBorder,
                  focusedErrorBorder: errorFieldFocusedBorder,
                  suffixIcon: IconButton(
                    icon: Icon(_isShowPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isShowPassword = !_isShowPassword;
                      });
                    },
                  ),
                ),
                validator: (value) => value != null && value.isEmpty
                    ? 'Enter a valid password'
                    : null,
              ),
            ),
            TextButton(
              onPressed:
                  _hasEmail && _hasPassword && formKey.currentState!.validate()
                      ? () {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthSignIn(
                              email: _emailText.text,
                              password: _passwordText.text,
                            ),
                          );
                        }
                      : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(_hasEmail &&
                        _hasPassword &&
                        formKey.currentState!.validate()
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColorLight),
                fixedSize: const MaterialStatePropertyAll(
                  Size(double.maxFinite, 50),
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
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return const CircularProgressIndicator(
                      color: Colors.white54,
                    );
                  }
                  return Text('Sign In'.toUpperCase());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget signUp(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        TextButton(
          onPressed: () {
            context.push(AppRoutes.signUpPathScreen);
          },
          child: Text(
            'Sign up',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: Theme.of(context).textTheme.bodySmall?.fontSize),
          ),
        )
      ],
    );
  }

  Widget forgotPass(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 32),
        child: TextButton(
          onPressed: () {
            context.push(AppRoutes.forgotPathScreen);
          },
          child: Text(
            'Forgot your password!?',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
