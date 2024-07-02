import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/blocs/events_view_mode_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/blocs/events_view_mode_state.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_calendar.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_view_mode.dart';
import 'package:flutter/material.dart';
import 'package:fempinya3_flutter_app/features/menu/presentation/widgets/menu_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/blocs/events_filter_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/blocs/events_filter_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/blocs/events_filter_state.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<StatusFilterBloc>(
          create: (context) => StatusFilterBloc(),
        ),
        BlocProvider<EventsViewModeBloc>(
          create: (context) => EventsViewModeBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Esdeveniments'),
        ),
        drawer: MenuWidget(),
        body: Column(
          children: [
            eventsWithAlertBanner(),
            Row(
              children: [
                const EventsViewModeWidged(),
                filtersButton(context),
              ],
            ),
            buildInputChips(),
            statusFilters(),
            BlocBuilder<EventsViewModeBloc, EventsViewModeState>(
                builder: (context, state) {
              return Visibility(
                  visible: state.isEventInViewModeCalendar(),
                  child: TableBasicsExample());
            }),
            Expanded(child: eventList())
          ],
        ),
      ),
    );
  }

  Card eventsWithAlertBanner() {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Text(
              'Zan se peleara con esto.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a row of input chips for filtering
  Widget buildInputChips() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        children: <Widget>[
          buildInputChip('Assajos'),
          buildInputChip('Sortides'),
          buildInputChip('Activitats'),
        ],
      ),
    );
  }

  /// Creates an individual input chip
  Widget buildInputChip(String label) {
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
      selectedColor: Colors.blue.shade100,
      checkmarkColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
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
    return Material(
      color: Theme.of(context).colorScheme.primary,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: PopupMenuButton<String>(
        color: Theme.of(context).colorScheme.surface,
        onSelected: (String result) {
          // Handle the selection
          switch (result) {
            case 'Assajos':
              // TODO: Add your filter logic for 'Assajos'
              break;
            case 'Sortides':
              // TODO: Add your filter logic for 'Sortides'
              break;
            case 'Activitats':
              // TODO: Add your filter logic for 'Activitats'
              break;
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Filter",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
            ],
          ),
        ),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem<String>(
              value: 'Assajos',
              child: Text('Assajos'),
            ),
            PopupMenuItem<String>(
              value: 'Sortides',
              child: Text('Sortides'),
            ),
            PopupMenuItem<String>(
              value: 'Activitats',
              child: Text('Activitats'),
            ),
          ];
        },
      ),
    );
  }

  BlocBuilder<StatusFilterBloc, StatusFilterState> statusFilters() {
    return BlocBuilder<StatusFilterBloc, StatusFilterState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildEventStatusCheckbox(state.showUndefined, 'Pendent', (value) {
              context.read<StatusFilterBloc>().add(StatusUndefined(value!));
            }),
            buildEventStatusCheckbox(state.showAnswered, 'Respost', (value) {
              context.read<StatusFilterBloc>().add(StatusAnswered(value!));
            }),
            buildEventStatusCheckbox(state.showWarning, 'Amb alerta', (value) {
              context.read<StatusFilterBloc>().add(StatusWarning(value!));
            }),
          ],
        );
      },
    );
  }

  Expanded buildEventStatusCheckbox(
      bool value, String title, Function(bool?) onChanged) {
    return Expanded(
      child: CheckboxListTile(
          // title: Text('Pendents'),
          title: Text(title),
          value: value,
          onChanged: onChanged),
    );
  }

  BlocBuilder eventList() {
    return BlocBuilder<StatusFilterBloc, StatusFilterState>(
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
