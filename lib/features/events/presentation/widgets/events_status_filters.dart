import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filter/events_filter_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filter/events_filter_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filter/events_filter_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsStatusFiltersWidged extends StatelessWidget {
  const EventsStatusFiltersWidged({super.key});

  @override
  Widget build(BuildContext context) {
    var translate = AppLocalizations.of(context)!;

    return BlocBuilder<EventsFilterBloc, EventsFilterState>(
      builder: (context, state) {
        return Wrap(
          spacing: 8.0,
          children: [
            buildEventStatusFilterChip(state.showUndefined,
                translate.eventPageStatusFilterPending, context, (value) {
              context
                  .read<EventsFilterBloc>()
                  .add(EventsStatusFilterUndefined(value));
            }),
            buildEventStatusFilterChip(state.showAnswered,
                translate.eventPageStatusFilterAnswered, context, (value) {
              context
                  .read<EventsFilterBloc>()
                  .add(EventsStatusFilterAnswered(value));
            }),
            buildEventStatusFilterChip(state.showWarning,
                translate.eventPageStatusFilterWarning, context, (value) {
              context
                  .read<EventsFilterBloc>()
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
