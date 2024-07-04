import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filters/events_filters_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filters/events_filters_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filters/events_filters_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsStatusFiltersWidget extends StatelessWidget {
  const EventsStatusFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var translate = AppLocalizations.of(context)!;

    return BlocBuilder<EventsFiltersBloc, EventsFiltersState>(
      builder: (context, state) {
        return Wrap(
          spacing: 8.0,
          children: [
            buildEventStatusFilterChip(state.showUndefined,
                translate.eventPageStatusFilterPending, context, (value) {
              context
                  .read<EventsFiltersBloc>()
                  .add(EventsStatusFilterUndefined(value));
            }),
            buildEventStatusFilterChip(state.showAnswered,
                translate.eventPageStatusFilterAnswered, context, (value) {
              context
                  .read<EventsFiltersBloc>()
                  .add(EventsStatusFilterAnswered(value));
            }),
            buildEventStatusFilterChip(state.showWarning,
                translate.eventPageStatusFilterWarning, context, (value) {
              context
                  .read<EventsFiltersBloc>()
                  .add(EventsStatusFilterWarning(value));
            }),
          ],
        );
      },
    );
  }

  Widget buildEventStatusFilterChip(
      bool selected, String label, context, ValueChanged<bool> onSelected) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Theme.of(context).colorScheme.primaryFixedDim,
      checkmarkColor: Theme.of(context).colorScheme.onSecondary,
    );
  }
}
