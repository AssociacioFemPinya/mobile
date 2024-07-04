import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filters/events_filters_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filters/events_filters_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filters/events_filters_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsFiltersInputChipsWidged extends StatelessWidget {
  const EventsFiltersInputChipsWidged({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsFilterBloc, EventsFilterState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 8.0,
          children: <Widget>[
            for (var item in state.eventTypeFilters)
              InputChip(
                label: Text(item.toLocalizedString(context)),
                onDeleted: () {
                  context
                      .read<EventsFilterBloc>()
                      .add(EventsTypeFiltersRemove(item));
                },
                selectedColor: Theme.of(context).colorScheme.primaryFixedDim,
                checkmarkColor: Theme.of(context).colorScheme.onPrimaryFixed,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(style: BorderStyle.none)),
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .primaryFixedDim
                    .withOpacity(0.3),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              )
          ],
        ),
      );
    });
  }
}
