import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app_mob/config/routes/app_router.dart';
import 'package:customer_app_mob/core/data/models/user.dart';
import 'package:customer_app_mob/core/shared/enums/loading_status.dart';
import 'package:customer_app_mob/config/routes/app_routes.dart';
import 'package:customer_app_mob/core/presentation/widgets/atoms/md_text_input/md_text_form.dart';
import 'package:customer_app_mob/core/presentation/widgets/atoms/md_button/md_filled.dart';
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
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SingleChildScrollView(
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
      height: 100,
      alignment: const AlignmentDirectional(1.0, 0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 30, 0),
        child: Text(
          'BigBlue',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 25,
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
            'Hi! \nWelcome',
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.w600, height: 1.2),
          ),
          Text('Let\'s get started by filling out the form below.',
              style: Theme.of(context).textTheme.bodyMedium),
          signInForm(context),
          signUp(context),
          forgotPass(context)
        ],
      ),
    );
  }

  Widget signInForm(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final isLoading = authState.status == LoadingStatus.loading;
    final isLoggingIn = authState.user == UserModel.empty;

    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 20, bottom: 10),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(bottom: 16),
              child: MDTextFormField(
                textController: _emailText,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  return value != null && !value.isValidEmail
                      ? 'Enter a valid email'
                      : null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(bottom: 16),
              child: MDTextFormField(
                textController: _passwordText,
                labelText: 'Password',
                autocorrect: false,
                enableSuggestions: false,
                obscureText: !_isShowPassword,
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
                validator: (value) {
                  return value != null && value.isEmpty
                      ? 'Enter a valid password'
                      : null;
                },
              ),
            ),
            MDFilledButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthSignIn(
                      email: _emailText.text,
                      password: _passwordText.text,
                    ));
              },
              text: 'SIGN IN',
              loading: isLoading && isLoggingIn,
              disabled: !isLoading &&
                      isLoggingIn &&
                      _hasEmail &&
                      _hasPassword &&
                      formKey.currentState!.validate()
                  ? false
                  : true,
            ),
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
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextButton(
          onPressed: () {
            AppRouter.router.push(AppRoutes.signUpPathScreen.fullPath);
          },
          child: Text(
            'Sign up',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize),
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
            AppRouter.router.push(AppRoutes.forgotPathScreen.fullPath);
          },
          child: Text(
            'Forgot your password?',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
