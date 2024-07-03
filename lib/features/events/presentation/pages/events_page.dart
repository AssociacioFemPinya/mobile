import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view/events_view_mode_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view/events_view_mode_state.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_calendar.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_view_mode.dart';
import 'package:fempinya3_flutter_app/features/menu/presentation/widgets/menu_widget.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filter/events_filter_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filter/events_filter_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filter/events_filter_state.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_type.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class EventsPage extends StatelessWidget {
  final List<DateMockup> dateEvents = generateMockup();
  final Set<String> _selectedFilters = {}; // TODO: move to block

  IconData getStatusIcon(EventStatusEnum status) {
    switch (status) {
      case EventStatusEnum.accepted:
        return Icons.check;
      case EventStatusEnum.declined:
        return Icons.close;
      case EventStatusEnum.unknown:
        return Icons.help_outline;
      case EventStatusEnum.undefined:
        return Icons.remove;
      case EventStatusEnum.warning:
        return Icons.warning;
    }
  }

  Color getStatusColor(EventStatusEnum status) {
    switch (status) {
      case EventStatusEnum.accepted:
        return Colors.green;
      case EventStatusEnum.declined:
        return Colors.red;
      case EventStatusEnum.unknown:
        return Colors.orange;
      case EventStatusEnum.undefined:
        return Colors.grey;
      case EventStatusEnum.warning:
        return Colors.orange;
    }
  }

@override
Widget build(BuildContext context) {
  var translate = AppLocalizations.of(context)!;

  return MultiBlocProvider(
    providers: [
      BlocProvider<EventsFilterBloc>(
        create: (context) => EventsFilterBloc(),
      ),
      BlocProvider<EventsViewModeBloc>(
        create: (context) => EventsViewModeBloc(),
      ),
    ],
    child: Scaffold(
      appBar: AppBar(
        title: Text(translate.eventsPageTitle),
      ),
      drawer: MenuWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0), 
        child: Column(
          children: [
            eventsWithAlertBanner(translate),
            Row(
              children: [
                const Expanded(child: EventsViewModeWidged()),
                filtersButton(context),
              ],
            ),
            buildInputChips(context, translate),
            const Divider(),
            statusFilters(translate),
            const Divider(),
            BlocBuilder<EventsViewModeBloc, EventsViewModeState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.isEventInViewModeCalendar(),
                  child: EventsCalendar(),
                );
              },
            ),
            Expanded(child: eventList()),
          ],
        ),
      ),
    ),
  );
}

  Card eventsWithAlertBanner(translate) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Text(
              translate.eventsPageEventsWithAlertBanner,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a row of input chips for filtering
  Widget buildInputChips(context, translate) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        children: <Widget>[
          buildInputChip(translate.eventsPageTypeChipPractice, context),
          buildInputChip(translate.eventsPageTypeChipOuts, context),
          buildInputChip(translate.eventsPageTypeChipActivities, context),
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
        side: const BorderSide(style: BorderStyle.none)
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryFixedDim.withOpacity(0.3), 
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, 
    );
  }

  Padding filtersButton(BuildContext context) {
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

    return Material(
      color: Theme.of(context).colorScheme.secondaryContainer,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: PopupMenuButton<EventTypeEnum>(
        color: Theme.of(context).colorScheme.surface,
        onSelected: (EventTypeEnum result) {
          // Handle the selection
          switch (result) {
            case EventTypeEnum.practice:
              // TODO: Add your filter logic for 'Assajos'
              break;
            case EventTypeEnum.outs:
              // TODO: Add your filter logic for 'Sortides'
              break;
            case EventTypeEnum.activities:
              // TODO: Add your filter logic for 'Activitats'
              break;
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                translate.eventsPageTypeFilterTitle,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: 3),
               Icon(
                Icons.arrow_drop_down,
                color:  Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
        itemBuilder: (BuildContext context) {
          return [
             PopupMenuItem<EventTypeEnum>(
              value: EventTypeEnum.practice,
              child: Text(translate.eventsPageTypeChipPractice),
            ),
             PopupMenuItem<EventTypeEnum>(
              value: EventTypeEnum.outs,
              child: Text(translate.eventsPageTypeChipOuts),
            ),
             PopupMenuItem<EventTypeEnum>(
              value: EventTypeEnum.activities,
              child: Text(translate.eventsPageTypeChipActivities),
            ),
          ];
        },
      ),
    );
  }

BlocBuilder<EventsFilterBloc, EventsFilterState> statusFilters(translate) {
  return BlocBuilder<EventsFilterBloc, EventsFilterState>(
    builder: (context, state) {
      return Wrap(
        spacing: 8.0,
        children: [
          buildEventStatusFilterChip(state.showUndefined, translate.eventPageStatusFilterPending , context, (value) {
            context
                .read<EventsFilterBloc>()
                .add(EventsStatusFilterUndefined(value));
          }),
          buildEventStatusFilterChip(state.showAnswered, translate.eventPageStatusFilterAnswered , context, (value) {
            context
                .read<EventsFilterBloc>()
                .add(EventsStatusFilterAnswered(value));
          }),
          buildEventStatusFilterChip(state.showWarning, translate.eventPageStatusFilterWarning, context, (value) {
            context
                .read<EventsFilterBloc>()
                .add(EventsStatusFilterWarning(value));
          }),
        ],
      );
    },
  );
}

Widget buildEventStatusFilterChip(bool selected, String label, context, ValueChanged<bool> onSelected) {
  return FilterChip(
    label: Text(label),
    selected: selected,
    onSelected: onSelected,
    selectedColor: Theme.of(context).colorScheme.primaryFixedDim,
    checkmarkColor: Theme.of(context).colorScheme.onSecondary,
  );
}


  BlocBuilder eventList() {
    return BlocBuilder<EventsFilterBloc, EventsFilterState>(
      builder: (context, state) {
        final filteredEvents = state.filterEvents(dateEvents);

        return ListView.builder(
          itemCount: filteredEvents.length,
          itemBuilder: (context, index) {
            final date = filteredEvents[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(date.date,
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Column(
                  children: date.events.map((event) {
                    return Card(
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      //color: getStatusColor(event.status),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: getStatusColor(event.status),
                          child: Icon(getStatusIcon(event.status),
                              color: Colors.white),
                        ),
                        title: Text(event.name),
                        subtitle: Text('${event.address} - ${event.dateHour}'),
                        trailing: Icon(event.icon),
                      ),
                    );
                  }).toList(),
                ),
                const Divider(),
              ],
            );
          },
        );
      },
    );
  }
}


