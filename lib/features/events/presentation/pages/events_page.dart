import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_calendar/events_calendar_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_repository/events_repository_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view_mode/events_view_mode_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_calendar.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_filters_button.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_filters_input_chips.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_list.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_status_filters.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_view_mode.dart';
import 'package:fempinya3_flutter_app/features/menu/presentation/widgets/menu_widget.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filters/events_filters_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var translate = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider<EventsFiltersBloc>(
          create: (context) => EventsFiltersBloc(),
        ),
        BlocProvider<EventsViewModeBloc>(
          create: (context) => EventsViewModeBloc(),
        ),
        BlocProvider<EventsRepositoryBloc>(
          create: (context) => EventsRepositoryBloc()..add(LoadEventsList()),
        ),
        BlocProvider<EventsCalendarBloc>(
          create: (context) => EventsCalendarBloc(),
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
              const Row(
                children: [
                  // Flexible(
                  //     child: Container(
                  //   //constraints: const BoxConstraints(maxWidth: 600),
                  //   child: const EventsViewModeWidged(),
                  // )),
                  EventsViewModeWidget(),
                  Spacer(),
                  EventsFiltersButton(),
                ],
              ),
              const EventsFiltersInputChipsWidget(),
              const Divider(),
              const EventsStatusFiltersWidget(),
              const Divider(),
              const EventsCalendar(),
              const Expanded(child: EventsListWidget()),
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
}
