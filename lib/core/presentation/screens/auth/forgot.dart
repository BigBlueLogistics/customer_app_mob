import 'package:customer_app_mob/core/presentation/widgets/atoms/md_text_input/md_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app_mob/core/presentation/widgets/atoms/md_button/md_filled.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/extensions/validation.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailText = TextEditingController();
  bool _hasEmail = false;

  @override
  void initState() {
    super.initState();

    _emailText.addListener(() {
      bool res = _emailText.text.isNotEmpty;

      setState(() => _hasEmail = res);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _emailText.dispose();
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
            'Reset! \nPassword',
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.w600, height: 1.2),
          ),
          Text('You will receive an e-mail in maximum 60 seconds.',
              style: Theme.of(context).textTheme.bodyMedium),
          forgotForm(context),
        ],
      ),
    );
  }

  Widget forgotForm(BuildContext context) {
    final isLoading = context.watch<AuthBloc>().state is AuthLoadingState;

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
            MDFilledButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  ResetPassword(
                    email: _emailText.text,
                  ),
                );
              },
              text: 'RESET',
              loading: isLoading,
              disabled:
                  !isLoading && _hasEmail && formKey.currentState!.validate()
                      ? false
                      : true,
            )
          ],
        ),
      ),
    );
  }
}
