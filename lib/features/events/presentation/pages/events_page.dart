import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_view_mode.dart';
import 'package:flutter/material.dart';
import 'package:fempinya3_flutter_app/features/menu/presentation/widgets/menu_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/blocs/events_view_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/blocs/events_view_events.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/blocs/events_view_state.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events.dart';

class EventsPage extends StatelessWidget {
  final List<DateMockup> dateEvents = generateMockup();

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
    return BlocProvider(
      create: (context) => StatusFilterBloc(dateEvents),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Esdeveniments'),
        ),
        drawer: MenuWidget(),
        body: Column(
          children: [
            //filtersButton(context), // Filter by tags shouldn't be necessary
            const EventsViewModeWidged(),
            statusFilters(),
            Expanded(child: eventList())
          ],
        ),
      ),
    );
  }

  // Padding filtersButton(BuildContext context) {
  //   return Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Align(
  //             alignment: Alignment.centerRight,
  //             child: buildFilterButton(context),
  //           ),
  //         );
  // }

  // /// Builds a filter button with a dropdown menu
  // Widget buildFilterButton(BuildContext context) {
  //   return PopupMenuButton<String>(
  //     icon: Icon(Icons.filter_list), // The filter icon
  //     onSelected: (String result) {
  //       // Handle the selection
  //       switch (result) {
  //         case 'All':
  //           // TODO: Add your filter logic for 'All'
  //           break;
  //         case 'Accepted':
  //           // TODO: Add your filter logic for 'Accepted'
  //           break;
  //         case 'Declined':
  //           // TODO: Add your filter logic for 'Declined'
  //           break;
  //         case 'Unknown':
  //           // TODO: Add your filter logic for 'Unknown'
  //           break;
  //         case 'Warning':
  //           // TODO: Add your filter logic for 'Warning'
  //           break;
  //       }
  //     },
  //     itemBuilder: (BuildContext context) {
  //       return [
  //         PopupMenuItem<String>(
  //           value: 'All',
  //           child: Text('All'),
  //         ),
  //         PopupMenuItem<String>(
  //           value: 'Accepted',
  //           child: Text('Accepted'),
  //         ),
  //         PopupMenuItem<String>(
  //           value: 'Declined',
  //           child: Text('Declined'),
  //         ),
  //         PopupMenuItem<String>(
  //           value: 'Unknown',
  //           child: Text('Unknown'),
  //         ),
  //         PopupMenuItem<String>(
  //           value: 'Warning',
  //           child: Text('Warning'),
  //         ),
  //       ];
  //     },
  //   );
  // }

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
