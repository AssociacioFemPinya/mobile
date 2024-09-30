import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fempinya3_flutter_app/features/menu/domain/entities/locale.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var translate = AppLocalizations.of(context)!;
    var selectedLocale = Localizations.localeOf(context).toString();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              AppLocalizations.of(context)!
                  .menuAppName("Alansito"), //TODO Zan username
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text(translate.menuHome),
            onTap: () {
              context.push(homeRoute);
            },
          ),
          ListTile(
            title: Text(translate.menuEvents),
            onTap: () {
              context.push(eventsRoute);
            },
          ),
          ListTile(
            title: Text(translate.menuNotifications),
            onTap: () {
              context.push(notificationsRoute);
            },
          ),
          const Divider(),
          Builder(
            builder: (context) => Consumer<LocaleModel>(
              builder: (context, localeModel, child) => ListTile(
                title: DropdownButton(
                  value: selectedLocale,
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(translate.menuLanguageSettings("en")),
                    ),
                    DropdownMenuItem(
                      value: 'es',
                      child: Text(translate.menuLanguageSettings("es")),
                    ),
                    DropdownMenuItem(
                      value: 'ca',
                      child: Text(translate.menuLanguageSettings("ca")),
                    ),
                    DropdownMenuItem(
                      value: 'fr',
                      child: Text(translate.menuLanguageSettings("fr")),
                    ),
                  ],
                  onChanged: (String? value) {
                    if (value != null) {
                      localeModel.set(Locale(value));
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
