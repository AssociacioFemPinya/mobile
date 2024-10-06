import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/event_view/event_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssistanceSelector extends StatelessWidget {
  const AssistanceSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventViewBloc, EventViewState>(
        builder: (context, state) {
      return SegmentedButton<EventStatusEnum>(
        segments: const <ButtonSegment<EventStatusEnum>>[
          ButtonSegment<EventStatusEnum>(
            value: EventStatusEnum.accepted,
            label: Text('Sí'),
          ),
          ButtonSegment<EventStatusEnum>(
            value: EventStatusEnum.declined,
            label: Text('No'),
          ),
          ButtonSegment<EventStatusEnum>(
            value: EventStatusEnum.unknown,
            label: Text('No ho sé'),
          ),
        ],
        selected: state.event?.status != EventStatusEnum.undefined ? <EventStatusEnum>{state.event!.status} : {},
        emptySelectionAllowed: true,
        onSelectionChanged: (Set<EventStatusEnum> newSelection) {
          context.read<EventViewBloc>().add(EventStatusModified(newSelection.first));
        },
      );
    });
  }
}
