import 'package:fempinya3_flutter_app/features/events/domain/entities/mockup.dart';
import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filter/events_filter_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filter/events_filter_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


final List<DateMockup> dateEvents = generateMockup(); // TODO: Create a block state for events list

class EventsListWidged extends StatelessWidget {
  const EventsListWidged({super.key});

  @override
  Widget build(BuildContext context) {
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
}