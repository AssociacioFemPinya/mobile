import 'package:fempinya3_flutter_app/features/login/login.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PublicDisplayUrlPage extends StatelessWidget {
  const PublicDisplayUrlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PublicDisplayUrlViewBloc()
        ..add(PublicDisplayUrlLoadEvent(
            email: context.read<AuthenticationBloc>().userEntity!.mail)),
      child: PublicDisplayUrlViewContentsPage(),
    );
  }
}

class PublicDisplayUrlViewContentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return BlocBuilder<PublicDisplayUrlViewBloc, PublicDisplayUrlViewState>(
      builder: (context, state) {
        if (state is PublicDisplayUrlViewInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PublicDisplayUrlLoadFailureStateEmptyUri ||
            state is PublicDisplayUrlLoadSuccessState ||
            state is PublicDisplayUrlLoadFailureStateWrongUri) {
          PublicDisplayUrlViewStateWithUrl s =
              state as PublicDisplayUrlViewStateWithUrl;
          return Scaffold(
            appBar: AppBar(
              title: Text(translate.menuPublicDisplayUrl),
            ),
            body: Center(
              child: _publicDisplayUrlViewContentsBody(s, translate),
            ),
          );
        } else {
          return Text('Unimplemented state');
        }
      },
    );
  }

  Widget _publicDisplayUrlViewContentsBody(
      PublicDisplayUrlViewStateWithUrl state, AppLocalizations translate) {
    if (state is PublicDisplayUrlLoadSuccessState) {
      return MyWebView(url: state.publicDisplayUrl.publicUrl);
    } else if (state is PublicDisplayUrlLoadFailureStateEmptyUri) {
      return Text(translate.publicDisplayUrlLoadFailureStateEmptyUri);
    } else if (state is PublicDisplayUrlLoadFailureStateWrongUri) {
      return Text(translate.publicDisplayUrlLoadFailureStateWrongUri);
    } else {
      return Text('Unimplemented state');
    }
  }
}
