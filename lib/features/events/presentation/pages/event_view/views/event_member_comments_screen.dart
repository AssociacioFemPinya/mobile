import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:fempinya3_flutter_app/core/theme_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class EventMemberCommentsScreen extends StatelessWidget {
  final EventEntity event;

  const EventMemberCommentsScreen({super.key, required this.event});

  void _onSavePressed(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    //TODO, success and error control
    // Aquí defines lo que quieres hacer cuando el botón de guardar sea presionado
    // Por ejemplo, podrías mostrar un mensaje, guardar datos, etc.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(translate.commonSnackBarSuccessSaving),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: defaultPadding),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                    child: BackButton(),
                  ),
                  Text(
                    translate.commonReturn,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextFormField(
                  maxLines: 5,
                  onSaved: (value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    hintText: translate.commentsScreenHintText,
                    labelText: translate.commentsScreenLabelText,
                    border: const OutlineInputBorder(),
                  ),
                )
            ),
            TextButton (
              onPressed: (){ _onSavePressed(context);},
              style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primaryFixedDim),
              child: Text(translate.commonSave, style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryFixed))
            )
          ],
        ),
      ),
    );
  }
}