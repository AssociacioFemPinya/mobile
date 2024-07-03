import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final Set<String> _selectedFilters = {}; // TODO: move to block

class EventsFiltersInputChipsWidged extends StatelessWidget {
  const EventsFiltersInputChipsWidged({super.key});

  @override
  Widget build(BuildContext context) {
    var translate = AppLocalizations.of(context)!;
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        children: <Widget>[
          buildInputChip(translate.eventsPageTypeChipTraining, context),
          buildInputChip(translate.eventsPageTypeChipPerformance, context),
          buildInputChip(translate.eventsPageTypeChipActivity, context),
        ],
      ),
    );
  }

  /// Creates an individual input chip
  Widget buildInputChip(String label, context) {
    return InputChip(
      label: Text(label),
      selected: _selectedFilters.contains(label),
      onSelected: (bool selected) {
        if (selected) {
          _selectedFilters.add(label);
        } else {
          _selectedFilters.remove(label);
        }
        // You might need to setState here or trigger a rebuild to update the UI
        // setState(() {});
      },
      onDeleted: () {},
      selectedColor: Theme.of(context).colorScheme.primaryFixedDim,
      checkmarkColor: Theme.of(context).colorScheme.onPrimaryFixed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(style: BorderStyle.none)),
      backgroundColor:
          Theme.of(context).colorScheme.primaryFixedDim.withOpacity(0.3),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
