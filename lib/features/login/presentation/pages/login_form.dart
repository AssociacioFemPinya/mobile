import 'package:fempinya3_flutter_app/features/login/login.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return BlocListener<LoginFormBloc, LoginFormState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(translate.loginSnackBarError)),
            );
          // Reset LoginForm status
          //to avoid snackBar trigger on each form event
          context.read<LoginFormBloc>().add(const LoginResetStatus());
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  translate.loginPageTitle,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildMailInput(context, translate),
                const SizedBox(height: 12),
                _buildPasswordInput(context, translate),
                const SizedBox(height: 16),
                _buildLoginButton(context, translate),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildMailInput(BuildContext context, AppLocalizations translate) {
  final isError =
      context.select((LoginFormBloc b) => b.state.mail.displayError) != null;
  return TextField(
    key: const Key('loginForm_mailInput_textField'),
    onChanged: (mail) {
      context.read<LoginFormBloc>().add(LoginMailChanged(mail));
    },
    decoration: InputDecoration(
      labelText: translate.loginPageEmailTitle,
      // errorText: displayError != null ? 'Invalid email' : null,
      errorText: isError ? translate.loginPageInvalidMail : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

Widget _buildPasswordInput(BuildContext context, AppLocalizations translate) {
  final isError = context.select(
        (LoginFormBloc bloc) => bloc.state.password.displayError,
      ) !=
      null;
  return TextField(
    key: const Key('loginForm_passwordInput_textField'),
    onChanged: (password) {
      context.read<LoginFormBloc>().add(LoginPasswordChanged(password));
    },
    obscureText: true,
    decoration: InputDecoration(
      labelText: translate.loginPagePasswordTitle,
      errorText: isError ? translate.loginPageInvalidPassword : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

Widget _buildLoginButton(BuildContext context, AppLocalizations translate) {
  final isInProgressOrSuccess = context.select(
    (LoginFormBloc bloc) => bloc.state.status.isInProgressOrSuccess,
  );

  if (isInProgressOrSuccess) return const CircularProgressIndicator();

  final isValid = context.select((LoginFormBloc bloc) => bloc.state.isValid);

  return ElevatedButton(
    key: const Key('loginForm_continue_raisedButton'),
    onPressed: isValid
        ? () => context.read<LoginFormBloc>().add(const LoginSubmitted())
        : null,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: Text(translate.loginPageLoginButton),
  );
}
