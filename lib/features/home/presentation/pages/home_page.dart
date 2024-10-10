import 'package:flutter/material.dart';
import 'package:fempinya3_flutter_app/features/menu/presentation/widgets/menu_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        final translate = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(translate.menuHome)),
      drawer: const MenuWidget(),
      body: const Center(
        child: Text('This is the home page'),
      ),
    );
  }
}
