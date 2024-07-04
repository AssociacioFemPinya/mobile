import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filter/events_filter_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filter/events_filter_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filter/events_filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsFiltersButton extends StatelessWidget {
  const EventsFiltersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: buildFilterButton(context),
      ),
    );
  }

  /// Builds a filter button with a dropdown menu
  Widget buildFilterButton(BuildContext context) {
    var translate = AppLocalizations.of(context)!;

    return BlocBuilder<EventsFilterBloc, EventsFilterState>(
        builder: (context, state) {
      return Material(
        color: Theme.of(context).colorScheme.secondaryContainer,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: PopupMenuButton<EventTypeEnum>(
          color: Theme.of(context).colorScheme.surface,
          onSelected: (EventTypeEnum value) {
            context
                  .read<EventsFilterBloc>()
                  .add(EventsTypeFiltersAdd(value));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  translate.eventsPageTypeFilterTitle,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 3),
                Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<EventTypeEnum>(
                value: EventTypeEnum.training,
                child: Text(translate.eventsPageTypeChipTraining),
              ),
              PopupMenuItem<EventTypeEnum>(
                value: EventTypeEnum.performance,
                child: Text(translate.eventsPageTypeChipPerformance),
              ),
              PopupMenuItem<EventTypeEnum>(
                value: EventTypeEnum.activity,
                child: Text(translate.eventsPageTypeChipActivity),
              ),
            ];
          },
        ),
      );
    });
  }
}
